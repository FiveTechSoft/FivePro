#include "dos.h"
#include "extend.h"

#define BYTE unsigned char
#define WORD unsigned int

#define DRV_5LOW  1
#define DRV_5HIGH 2
#define DRV_3LOW  3
#define DRV_3HIGH 4

#define DSK_LOW   0
#define DSK_HIGH  1

#define SIZE_128  0
#define SIZE_256  1
#define SIZE_512  2
#define SIZE_1024 3

typedef struct tagField
{
   BYTE nCylinder;
   BYTE nHead;
   BYTE nSectorNumber;
   BYTE nSectorSize;
} Field;

CLIPPER nFormatTrk()
{
   BYTE nWichDrive    = _parni( 1 );      // A = 0, B = 1, ...
   BYTE nDiskDensity  = _parni( 2 );      // 0 Low, 1 High
   BYTE nCylinder     = _parni( 3 );      // 0 ...
   BYTE nHead         = _parni( 4 );      // 0 Up, 1 Down
   BYTE nDriveType = DRV_5LOW;            // valor por defecto
   BYTE nNumberTracks = 39;               //   "    "     "
   BYTE nNumberSectors = 9;               //   "    "     "
   BYTE nSector;
   Field Fields[ 18 ];
   WORD FieldsSegment = FP_SEG( Fields );
   WORD FieldsOffset  = FP_OFF( Fields );
   WORD OldDdptSegment, OldDdptOffset, NewDdptSegment, NewDdptOffset;

   asm mov ah, 8;                     // Obtener los datos del Drive
   asm mov dl, nWichDrive;            // Ojo, quiz  esto no vaya bien...
   asm int 0x13;                      // en m quinas antiguas
   asm mov nDriveType, bl;

   if( nDriveType != DRV_5LOW )
   {
      switch( nDriveType )
      {
         case DRV_5HIGH:
              if( nDiskDensity == DSK_HIGH )
              {
                 nNumberTracks  = 79;
                 nNumberSectors = 15;
              }
              break;

         case DRV_3LOW:
              nNumberTracks  = 79;
              nNumberSectors =  9;
              break;

         case DRV_3HIGH:
              if( nDiskDensity == DSK_LOW )
              {
                 nNumberTracks  = 79;
                 nNumberSectors =  9;
              }
              else
              {
                 nNumberTracks  = 79;
                 nNumberSectors = 18;
              }
              break;
      }
   }

   for( nSector = 1; nSector <= nNumberSectors; nSector++ )
   {
      Fields[ nSector - 1 ].nCylinder     = nCylinder;
      Fields[ nSector - 1 ].nHead         = nHead;
      Fields[ nSector - 1 ].nSectorNumber = nSector;
      Fields[ nSector - 1 ].nSectorSize   = SIZE_512;
   }

   if( nDriveType != DRV_5LOW )
   {
      asm mov ah, 0x35;                 // Guardar tabla antiguas RomBios
      asm mov al, 0x1E;
      asm int 0x21;                     // DOS
      asm mov OldDdptSegment, es;
      asm mov OldDdptOffset, bx;

      asm mov ah, 0x17;                 // Informar de
      asm mov al, 3;                    // Tipo Drive / Disco a usar
      asm mov dl, 0;
      asm int 0x13;                     // RomBios

      asm mov ah, 0x18;                 // Conseguir tabla nueva RomBios
      asm mov ch, nNumberTracks;        // n§ max. Pistas formato standard
      asm mov cl, nNumberSectors;       // n§ max. Sectores formato   "
      asm mov dl, nWichDrive;
      asm int 0x13;                     // RomBios
      asm mov NewDdptSegment, es;
      asm mov NewDdptOffset, di;

      asm push ds;
      asm push dx;

      asm mov ah, 0x25;                // Establecer esa nueva tabla
      asm mov al, 0x1E;
      asm mov ds, NewDdptSegment;
      asm mov dx, NewDdptOffset;
      asm int 0x21;                    // DOS

      asm pop dx;
      asm pop ds;
   }

   asm mov ah, 5;                   // Formatear
   asm mov al, nNumberSectors;
   asm mov ch, nCylinder;
   asm mov dh, nHead;
   asm mov dl, nWichDrive;
   asm mov es, FieldsSegment;
   asm mov bx, FieldsOffset;
   asm int 0x13;                    // RomBios

   if( nDriveType != DRV_5LOW )
   {
      asm push ds;
      asm push dx;

      asm mov ah, 0x25;                // Restablecer tabla original
      asm mov al, 0x1E;
      asm mov ds, OldDdptSegment;
      asm mov dx, OldDdptOffset;
      asm int 0x21;                    // DOS

      asm pop dx;
      asm pop ds;
   }
   _ret();                             // return nil de Clipper
}
