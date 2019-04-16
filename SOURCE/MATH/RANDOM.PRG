#include "FivePro.ch"

static nRandom

//----------------------------------------------------------------------------//

function nRandom( nMax )

  local nTemp

  DEFAULT nMax := 65535, nRandom := Seconds()

  nTemp   = ( nRandom * Seconds() ) % ( nMax + 1 )
  nRandom = nTemp + Seconds()

return Int( nTemp )

//----------------------------------------------------------------------------//
