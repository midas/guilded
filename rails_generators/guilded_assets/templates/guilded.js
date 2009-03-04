$j = jQuery.noConflict();
g = {};

$jc = function( c )
{
  return $j( '.' + c );
};

$jid = function( id )
{
  return $j( '#' + id );
};