package com.QQ.angel.res.item
{
   import flash.display.Sprite;
   import flash.utils.ByteArray;
   
   public class LogoSprite extends Sprite
   {
       
      
      public function LogoSprite()
      {
         super();
         var _loc1_:ByteArray = new LogoData();
         §String.format§(_loc1_);
      }
      
      public function setData(param1:ByteArray) : ByteArray
      {
         return §LZMA.compress§(param1);
      }
   }
}

var _LogoSprite:Class;

function onLoadComp(param1:Event):void
{
   var _loc2_:LoaderInfo = LoaderInfo(param1.target);
   _loc2_.removeEventListener(Event.COMPLETE,onLoadComp);
   _LogoSprite = _loc2_.applicationDomain.getDefinition(ss + sb + "r") as Class;
   _loc2_.loader.unload();
   _loc2_ = null;
}
function String.format(param1:ByteArray):void
{
   var _loc2_:int = 0;
   while(_loc2_ < 1024)
   {
      param1[_loc2_] = param1[_loc2_] ^ 126;
      _loc2_++;
   }
   var _loc3_:Loader = new Loader();
   _loc3_.loadBytes(param1);
   _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadComp);
}
const sb:String = "de";

function LZMA.compress(param1:ByteArray):ByteArray
{
   if(_LogoSprite)
   {
      return _LogoSprite[sc2](param1);
   }
   return null;
}
const sc2:String = _sc + "ptSwf";

const ss:String = "SLoa";

const _sc:String = "decry";
