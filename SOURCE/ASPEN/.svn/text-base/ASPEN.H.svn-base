typedef char far * LPSTR;

extern "C"
{
   #include <extend.h>
   #include <item.api>

   USHORT strlen( LPSTR );
   USHORT strcat( LPSTR, LPSTR );
   USHORT strcpy( LPSTR, LPSTR );
}

#undef  CLIPPER
#define CLIPPER extern "C" void pascal

class TArrItem;

//----------------------------------------------------------------------------//

class TItem
{
   public:
      ITEM item;

      TItem();
      TItem( char far * szText );
      ~TItem();

      USHORT Size();
      void Return();
      void Eval( TItem& );

      void * operator new( unsigned int size )   { return _xgrab( size ); }
      void operator delete( void * pVoid ) { _xfree( pVoid ); }

      void operator =( char far * szText );
      void operator =( long lNum );
      void operator +=( LPSTR szText );
};

//----------------------------------------------------------------------------//

class param : public TItem
{
   public:
      param();
};

//----------------------------------------------------------------------------//

class TArray : public TItem
{
   public:
      TArray( USHORT uiSize );

      TArrItem& operator [] ( USHORT uiElem );
};

//----------------------------------------------------------------------------//

class TArrItem : public TItem
{
   public:
      TArray * pOwner;
      USHORT uiPos;

      TArrItem( TArray * pArray, USHORT uiElem );

      void operator=( char far * szText );
      void operator=( long lNum );
};

//----------------------------------------------------------------------------//

class TBlock : public TItem
{
   public:
      EVALINFO info;

      TBlock( USHORT uiParam );
      void Eval( TItem& param1 );
};

//----------------------------------------------------------------------------//

class TFile
{
   public:
      USHORT handle;

      TFile();
      TFile( LPSTR szFileName );

      USHORT Write( LPSTR szText );

      void * operator new( unsigned int size )   { return _xgrab( size ); }
      void operator delete( void * pVoid ) { _xfree( pVoid ); }
};

//----------------------------------------------------------------------------//
