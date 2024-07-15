package BitmapFont.font.v9
{
   import BitmapFont.IDispose;
   import BitmapFont.font.FontLayoutInfo;
   import BitmapFont.font.LayoutInfo;
   import BitmapFont.util.BooleanRef;
   import BitmapFont.util.IntergerRef;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class FontBase implements IDispose
   {
      
      private static var s_layoutInfoBuffer:Array = new Array(64);
      
      private static var s_scrollV:uint;
      
      private static var s_lineNum:uint;
       
      
      protected var m_fontMappingArray:Array;
      
      protected var m_fontSize:uint;
      
      internal var m_defaultSpaceSize:uint;
      
      protected var m_baseLine:int;
      
      public var completeFunction:Function;
      
      public function FontBase()
      {
         super();
      }
      
      public static function createFont(param1:ByteArray, param2:BitmapData) : FontBase
      {
         param1.endian = Endian.LITTLE_ENDIAN;
         if(param1[0] == 77 && param1[1] == 68 && param1[2] == 70)
         {
            return new ModuleFont(param1,param2);
         }
         return null;
      }
      
      public function render(param1:TextFieldBitmap, param2:TextFormatBitmap) : void
      {
         var _loc3_:ByteArray = this.getQuickData(param1);
         if(_loc3_.length > 1)
         {
            _loc3_.position = 0;
            this.fontRender(param1,_loc3_);
         }
      }
      
      protected function fontRender(param1:TextFieldBitmap, param2:ByteArray) : void
      {
      }
      
      public function formatText(param1:TextFieldBitmap, param2:TextFormatBitmap) : Array
      {
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:RetFontLayoutInfo = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Array = null;
         var _loc3_:ByteArray = this.getQuickData(param1);
         if(_loc3_.length == 0)
         {
            _loc4_ = param1.text;
            _loc5_ = Number(param2.size) / this.m_fontSize;
            _loc6_ = int(_loc5_ * param1.m_textFormat.spaceSize) + param2.letterSpacing;
            _loc7_ = new RetFontLayoutInfo();
            _loc8_ = param1.width - Number(param2.leftMargin) - Number(param2.rightMargin);
            _loc9_ = param1.height;
            if(!(_loc10_ = this.getLayout(_loc4_,param1,param2,_loc6_,_loc7_)))
            {
               _loc3_.writeByte(0);
               return null;
            }
            this.writeQuickData(_loc4_,_loc3_,param2,_loc10_,_loc6_,_loc7_,_loc8_,_loc9_);
            return _loc10_;
         }
         return null;
      }
      
      private function getLayout(param1:String, param2:TextFieldBitmap, param3:TextFormatBitmap, param4:int, param5:RetFontLayoutInfo) : Array
      {
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:Boolean = false;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:String = null;
         var _loc23_:FontLayoutInfo = null;
         var _loc24_:uint = 0;
         var _loc25_:String = null;
         var _loc26_:uint = 0;
         var _loc27_:int = 0;
         var _loc28_:String = null;
         var _loc29_:FontLayoutInfo = null;
         var _loc6_:Number = param2.width - Number(param3.leftMargin) - Number(param3.rightMargin);
         ASSERT(Boolean(param5) && Boolean(param1),"error");
         var _loc7_:Number = param2.height;
         var _loc8_:uint = 0;
         if(_loc6_ < param3.size)
         {
            return null;
         }
         s_layoutInfoBuffer.length = 0;
         var _loc11_:Number = _loc7_ - Number(param3.size);
         var _loc12_:IntergerRef = new IntergerRef();
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Boolean = false;
         var _loc16_:BooleanRef = new BooleanRef();
         _loc9_ = 0;
         _loc10_ = 0;
         do
         {
            if(_loc9_ <= _loc11_)
            {
               _loc14_++;
            }
            _loc17_ = 0;
            _loc15_ = false;
            _loc18_ = false;
            while(true)
            {
               _loc25_ = param1.charAt(_loc8_);
               if((_loc26_ = param1.charCodeAt(_loc8_)) === 0)
               {
                  break;
               }
               if(_loc25_ == "\n" || _loc25_ == "\r")
               {
                  if(_loc25_ == "\r" && param1.charAt(_loc8_ + 1) == "\n")
                  {
                     _loc8_++;
                  }
                  _loc8_++;
                  _loc15_ = true;
                  break;
               }
               _loc16_.value = false;
               if(!_loc18_)
               {
                  _loc27_ = this.getLayoutWordSize(param1,_loc8_,_loc16_,_loc12_,param4,param3);
                  if(_loc17_ + _loc12_.value > _loc6_ + param3.letterSpacing)
                  {
                     if(_loc13_ != int(_loc8_))
                     {
                        break;
                     }
                     _loc18_ = true;
                  }
                  else
                  {
                     _loc17_ += _loc12_.value;
                     _loc8_ += _loc27_;
                  }
               }
               else
               {
                  _loc16_.value = this.getLayoutFontSize(_loc25_,_loc12_,param4,param3);
                  if(_loc17_ + _loc12_.value > _loc6_ + param3.letterSpacing)
                  {
                     if(_loc13_ == int(_loc8_))
                     {
                        _loc13_++;
                        _loc8_++;
                        _loc17_ = Number(param3.letterSpacing);
                     }
                     break;
                  }
                  _loc17_ += _loc12_.value;
                  _loc8_++;
               }
            }
            _loc20_ = _loc19_ = int(_loc8_ - 1);
            _loc21_ = 2;
            _loc22_ = "0";
            while((param1.charAt(_loc19_) == "\n" || param1.charAt(_loc19_) == "\r") && _loc21_ > 0 && param1.charAt(_loc19_) != _loc22_)
            {
               _loc22_ = param1.charAt(_loc19_);
               _loc21_--;
               _loc19_--;
            }
            while(_loc19_ > _loc13_)
            {
               _loc28_ = param1.charAt(_loc19_);
               _loc16_.value = this.getLayoutFontSize(_loc28_,_loc12_,param4,param3);
               if(!_loc16_.value)
               {
                  _loc17_ -= Number(param3.letterSpacing);
                  break;
               }
               _loc17_ -= _loc12_.value;
               _loc19_--;
            }
            if(param2.m_textWidth < _loc17_)
            {
               param2.m_textWidth = _loc17_;
            }
            (_loc23_ = new FontLayoutInfo()).spaceWidth = _loc6_ - _loc17_;
            _loc23_.startIndex = _loc13_;
            _loc23_.endingIndex = _loc19_ + 1;
            _loc23_.endingIndexWithSpace = _loc20_ + 1;
            s_layoutInfoBuffer.push(_loc23_);
            if(!_loc15_ && param1.charAt(_loc8_) == " ")
            {
               _loc8_++;
            }
            _loc13_ = int(_loc8_);
            if(_loc9_ <= _loc11_)
            {
               _loc10_ += param3.size + param3.leading;
            }
            _loc9_ += param3.size + param3.leading;
         }
         while((_loc24_ = param1.charCodeAt(_loc8_)) !== 0);
         
         if(_loc15_)
         {
            _loc17_ = 0;
            (_loc29_ = new FontLayoutInfo()).spaceWidth = _loc6_ - _loc17_;
            _loc29_.startIndex = _loc13_;
            _loc29_.endingIndex = _loc13_;
            _loc29_.endingIndexWithSpace = _loc13_;
            s_layoutInfoBuffer.push(_loc29_);
            if(_loc9_ <= _loc11_)
            {
               _loc14_++;
            }
            if(_loc9_ <= _loc11_)
            {
               _loc10_ += param3.size + param3.leading;
            }
            _loc9_ += param3.size + param3.leading;
         }
         param2.m_maxScrollV = s_layoutInfoBuffer.length - _loc14_;
         ASSERT(param2.m_maxScrollV >= 0,"error m_maxScrollV");
         if(param2.m_scrollV > param2.m_maxScrollV)
         {
            param2.m_scrollV = param2.m_maxScrollV;
         }
         s_lineNum = _loc14_;
         s_scrollV = param2.m_scrollV;
         param5.fristY = 0;
         param5.fontNum = _loc8_;
         _loc9_ -= Number(param3.leading);
         _loc10_ -= Number(param3.leading);
         if(param3.alignInfo & LayoutInfo.ALIGN_VCENTER)
         {
            param5.fristY = int(_loc7_ - _loc10_) >> 1;
         }
         else if(param3.alignInfo & LayoutInfo.ALIGN_BOTTOM)
         {
            param5.fristY = int(_loc7_ - _loc10_);
         }
         param2.m_textHeight = _loc10_;
         param2.m_textHeightWithHide = _loc9_;
         return s_layoutInfoBuffer;
      }
      
      protected function wirteAQuickData(param1:ByteArray, param2:uint, param3:Number, param4:Number, param5:Number, param6:String) : void
      {
      }
      
      protected function writeQuickData(param1:String, param2:ByteArray, param3:TextFormatBitmap, param4:Array, param5:uint, param6:RetFontLayoutInfo, param7:Number, param8:Number) : void
      {
         var _loc19_:FontLayoutInfo = null;
         var _loc21_:Number = NaN;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:String = null;
         var _loc25_:uint = 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:Boolean = false;
         var _loc29_:uint = 0;
         var _loc9_:Point;
         (_loc9_ = new Point()).x = 0;
         var _loc10_:uint = 0;
         var _loc11_:IntergerRef = new IntergerRef();
         var _loc12_:Number = Number(param3.size) / this.m_fontSize;
         var _loc13_:Number = Number(param3.size) + Number(param3.leading);
         var _loc14_:int = param8 + param6.fristY - Number(param3.size);
         var _loc15_:uint = param2.position;
         param2.writeInt(param6.fontNum);
         param2.writeInt(uint(param3.color));
         var _loc16_:uint = 0;
         _loc9_.y = param6.fristY - _loc13_;
         var _loc17_:uint = s_lineNum;
         ASSERT(param4.length >= _loc17_,"error data");
         var _loc18_:uint = s_scrollV;
         _loc17_ += _loc18_;
         var _loc20_:uint = _loc18_;
         while(_loc20_ < _loc17_)
         {
            _loc21_ = (_loc19_ = param4[_loc20_]).spaceWidth;
            _loc22_ = _loc19_.startIndex;
            _loc23_ = _loc19_.endingIndex;
            _loc9_.y += _loc13_;
            ASSERT(_loc9_.y <= _loc14_,"error");
            if(param3.alignInfo & LayoutInfo.ALIGN_HCENTER)
            {
               _loc9_.x = param3.leftMargin + _loc21_ / 2;
            }
            else if(param3.alignInfo & LayoutInfo.ALIGN_RIGHT)
            {
               _loc9_.x = Number(param3.leftMargin) + _loc21_;
            }
            else
            {
               _loc9_.x = Number(param3.leftMargin);
            }
            _loc9_.x = int(_loc9_.x);
            _loc10_ = 0;
            _loc26_ = _loc22_;
            _loc27_ = _loc23_;
            while(_loc26_ < _loc27_)
            {
               _loc24_ = param1.charAt(_loc26_);
               _loc25_ = param1.charCodeAt(_loc26_);
               ASSERT(_loc24_ != "\n" && _loc24_ != "\r" && _loc25_ !== 0,"error");
               _loc28_ = this.getLayoutFontSize(_loc24_,_loc11_,param5,param3);
               _loc10_ += _loc11_.value;
               ASSERT(_loc10_ <= param7 + param3.letterSpacing,"error");
               if(!_loc28_)
               {
                  this.wirteAQuickData(param2,this.m_fontSize,_loc12_,_loc9_.x + _loc10_ - _loc11_.value,_loc9_.y,_loc24_);
                  _loc16_++;
               }
               _loc26_++;
            }
            _loc20_++;
         }
         if(_loc16_ != param6.fontNum)
         {
            _loc29_ = param2.position;
            param2.position = _loc15_;
            param2.writeInt(_loc16_);
            param2.position = _loc29_;
         }
      }
      
      protected function getLayoutFontSize(param1:String, param2:IntergerRef, param3:uint, param4:TextFormatBitmap) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         if(param1 == " ")
         {
            param2.value = param3;
            _loc5_ = true;
         }
         else if((_loc6_ = this.getFontMappedIndex(param1,param2,Number(param4.size))) == -1)
         {
            param2.value = param3;
            _loc5_ = true;
         }
         else
         {
            param2.value = int(param2.value + 0.9) + int(param4.letterSpacing);
            _loc5_ = false;
         }
         return _loc5_;
      }
      
      protected function getLayoutWordSize(param1:String, param2:uint, param3:BooleanRef, param4:IntergerRef, param5:uint, param6:TextFormatBitmap) : int
      {
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         var _loc11_:Boolean = false;
         var _loc7_:int = 0;
         param4.value = 0;
         var _loc8_:IntergerRef = new IntergerRef();
         while(true)
         {
            _loc9_ = param1.charCodeAt(param2 + _loc7_);
            _loc10_ = param1.charAt(param2 + _loc7_);
            if(!(_loc9_ >= "a".charCodeAt(0) && _loc9_ <= "z".charCodeAt(0) || _loc9_ >= "A".charCodeAt(0) && _loc9_ <= "Z".charCodeAt(0) || _loc10_ == "," || _loc10_ == "." || _loc10_ == "?" || _loc10_ == "!" || _loc10_ == "\"" || _loc10_ == "\'"))
            {
               break;
            }
            _loc11_ = this.getLayoutFontSize(_loc10_,_loc8_,param5,param6);
            param4.value += _loc8_.value;
            param3.value = _loc11_;
            _loc7_++;
            if(_loc11_)
            {
               return _loc7_;
            }
         }
         if(_loc7_ == 0)
         {
            _loc11_ = this.getLayoutFontSize(_loc10_,_loc8_,param5,param6);
            param4.value += _loc8_.value;
            param3.value = _loc11_;
            return 1;
         }
         return _loc7_;
      }
      
      protected function initTextBuffer(param1:String, param2:TextFieldBitmap) : String
      {
         return null;
      }
      
      public function prepareText(param1:TextFormatBitmap, param2:String, param3:int = -1) : void
      {
      }
      
      protected function prepareAText(param1:TextFormatBitmap, param2:String) : void
      {
      }
      
      protected function initFontMappingArray(param1:ByteArray) : void
      {
         var _loc2_:uint = param1.readUnsignedByte();
         this.m_fontMappingArray = new Array(_loc2_);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this.m_fontMappingArray[_loc3_] = FontMapping.createFontMapping(param1);
            _loc3_++;
         }
      }
      
      protected function getFontMappedIndex(param1:String, param2:Object = null, param3:int = 0) : int
      {
         var _loc4_:int = 0;
         var _loc6_:FontMapping = null;
         var _loc5_:int = param1.charCodeAt(0);
         var _loc7_:uint = 0;
         while(_loc7_ < this.m_fontMappingArray.length)
         {
            if((_loc4_ = (_loc6_ = FontMapping(this.m_fontMappingArray[_loc7_])).getMappedId(_loc5_)) != -1)
            {
               if(param2)
               {
                  param2.value = this.getFontWidth(param1,_loc4_,param3);
               }
               return _loc4_;
            }
            _loc7_++;
         }
         return -1;
      }
      
      protected function getFontWidth(param1:String, param2:int, param3:int = 0) : Number
      {
         return 0;
      }
      
      protected function getFontAdvance(param1:String, param2:int, param3:int = 0, param4:String = "") : Number
      {
         return this.getFontWidth(param1,param2,param3);
      }
      
      protected function getQuickData(param1:TextFieldBitmap) : ByteArray
      {
         return param1.m_quickDrawData;
      }
      
      public function get defaultFontSize() : uint
      {
         return this.m_fontSize;
      }
      
      public function get defaultSpaceSize() : uint
      {
         return this.m_defaultSpaceSize;
      }
      
      public function getDefaultFontSize() : int
      {
         return this.m_fontSize;
      }
      
      public function dispose() : void
      {
         var _loc1_:uint = 0;
         if(this.m_fontMappingArray)
         {
            _loc1_ = 0;
            while(_loc1_ < this.m_fontMappingArray.length)
            {
               this.m_fontMappingArray[_loc1_].dispose();
               _loc1_++;
            }
            this.m_fontMappingArray.length = 0;
            this.m_fontMappingArray = null;
         }
         this.completeFunction = null;
      }
   }
}

class RetFontLayoutInfo
{
    
   
   public var fristY:Number = 0;
   
   public var fontNum:uint;
   
   public function RetFontLayoutInfo()
   {
      super();
   }
}
