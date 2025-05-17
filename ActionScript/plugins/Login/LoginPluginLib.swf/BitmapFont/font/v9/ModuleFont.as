package BitmapFont.font.v9
{
   import BitmapFont.util.ByteArrayUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.utils.ByteArray;
   
   public class ModuleFont extends FontBase
   {
      
      internal var m_fontBitmapData:BitmapData;
      
      private var m_fontNum:uint;
      
      private var m_fontModuleBlockArray:Array;
      
      public function ModuleFont(param1:ByteArray, param2:BitmapData)
      {
         var fileStart:uint;
         var fileLength:uint;
         var i:uint;
         var flag:int;
         var hasXOffData:Boolean;
         var hasYOffData:Boolean;
         var imgDataLength:uint;
         var imgBa:ByteArray = null;
         var loader:Loader = null;
         var _this:ModuleFont = null;
         var fontData:ByteArray = param1;
         var _bitmapData:BitmapData = param2;
         super();
         fontData.position += 4;
         fileStart = fontData.position;
         fileLength = fontData.readUnsignedInt();
         m_fontSize = ByteArrayUtil.readUnsignedByteOrShort(fontData);
         m_defaultSpaceSize = ByteArrayUtil.readUnsignedByteOrShort(fontData);
         initFontMappingArray(fontData);
         this.m_fontNum = ByteArrayUtil.readUnsignedShortOrInt(fontData);
         this.m_fontModuleBlockArray = new Array();
         i = 0;
         while(i < this.m_fontNum)
         {
            this.m_fontModuleBlockArray[i] = new FontModuleBlock();
            this.m_fontModuleBlockArray[i].x = ByteArrayUtil.readUnsignedByteOrShort(fontData);
            this.m_fontModuleBlockArray[i].y = ByteArrayUtil.readUnsignedByteOrShort(fontData);
            this.m_fontModuleBlockArray[i].w = ByteArrayUtil.readUnsignedByteOrShort(fontData);
            this.m_fontModuleBlockArray[i].h = ByteArrayUtil.readUnsignedByteOrShort(fontData);
            i++;
         }
         flag = fontData.readByte();
         hasXOffData = (flag & 1) != 0;
         hasYOffData = (flag & 2) != 0;
         if(hasXOffData || hasYOffData)
         {
            i = 0;
            while(i < this.m_fontNum)
            {
               if(hasXOffData)
               {
                  this.m_fontModuleBlockArray[i].xOff = fontData.readByte();
               }
               if(hasYOffData)
               {
                  this.m_fontModuleBlockArray[i].yOff = fontData.readByte();
               }
               i++;
            }
         }
         imgDataLength = ByteArrayUtil.readUnsignedShortOrInt(fontData);
         if(_bitmapData != null)
         {
            this.m_fontBitmapData = _bitmapData;
         }
         else
         {
            imgBa = new ByteArray();
            fontData.readBytes(imgBa,0,imgDataLength);
            loader = new Loader();
            _this = this;
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
            {
               param1.target.removeEventListener(param1.type,arguments.callee);
               var _loc3_:LoaderInfo = LoaderInfo(param1.currentTarget);
               m_fontBitmapData = Bitmap(_loc3_.content).bitmapData;
               _loc3_.loader.unload();
               if(completeFunction != null)
               {
                  completeFunction(_this);
               }
            });
            loader.loadBytes(imgBa);
            imgBa.length = 0;
            imgBa = null;
         }
      }
      
      override public function dispose() : void
      {
         if(this.m_fontBitmapData)
         {
            this.m_fontBitmapData.dispose();
            this.m_fontBitmapData = null;
         }
         if(this.m_fontModuleBlockArray)
         {
            this.m_fontModuleBlockArray.length = 0;
            this.m_fontModuleBlockArray = null;
         }
         super.dispose();
      }
      
      override protected function getFontWidth(param1:String, param2:int, param3:int = 0) : Number
      {
         ASSERT(param2 >= 0 && param2 < int(this.m_fontNum),"error");
         return param3 / m_fontSize * this.m_fontModuleBlockArray[param2].w;
      }
      
      override protected function wirteAQuickData(param1:ByteArray, param2:uint, param3:Number, param4:Number, param5:Number, param6:String) : void
      {
         var _loc7_:int = getFontMappedIndex(param6);
         ASSERT(_loc7_ >= 0 && _loc7_ < int(this.m_fontNum),"error");
         var _loc8_:FontModuleBlock = this.m_fontModuleBlockArray[_loc7_];
         param1.writeFloat(param3);
         param1.writeInt(param4);
         param1.writeInt(param5);
         param1.writeInt(_loc8_.x);
         param1.writeInt(_loc8_.y);
         param1.writeInt(_loc8_.w);
         param1.writeInt(_loc8_.h);
         param1.writeInt(_loc8_.xOff);
         param1.writeInt(_loc8_.yOff);
      }
      
      override protected function fontRender(param1:TextFieldBitmap, param2:ByteArray) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc3_:uint = param2.readUnsignedInt();
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Graphics = param1.graphics;
         var _loc5_:Matrix = new Matrix();
         var _loc6_:uint = param2.readUnsignedInt();
         var _loc7_:uint = 0;
         while(_loc7_ < _loc3_)
         {
            _loc8_ = param2.readFloat();
            _loc9_ = param2.readInt();
            _loc10_ = param2.readInt();
            _loc11_ = param2.readUnsignedInt();
            _loc12_ = param2.readUnsignedInt();
            _loc13_ = param2.readUnsignedInt();
            _loc14_ = param2.readUnsignedInt();
            _loc15_ = param2.readInt() * _loc8_;
            _loc16_ = param2.readInt() * _loc8_;
            _loc5_.identity();
            _loc5_.translate(-_loc11_,-_loc12_);
            _loc5_.scale(_loc8_,_loc8_);
            _loc5_.translate(_loc9_ + _loc15_,_loc10_ + _loc16_);
            _loc4_.beginBitmapFill(this.m_fontBitmapData,_loc5_,false,true);
            _loc4_.drawRect(_loc9_ + _loc15_,_loc10_ + _loc16_,_loc13_ * _loc8_,_loc14_ * _loc8_);
            _loc4_.endFill();
            _loc7_++;
         }
      }
   }
}

class FontModuleBlock
{
   
   public var x:uint;
   
   public var y:uint;
   
   public var w:uint;
   
   public var h:uint;
   
   public var xOff:int;
   
   public var yOff:int;
   
   public function FontModuleBlock()
   {
      super();
   }
}
