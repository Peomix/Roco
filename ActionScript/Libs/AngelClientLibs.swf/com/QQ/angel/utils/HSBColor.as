package com.QQ.angel.utils
{
   public final class HSBColor
   {
      
      private var _hue:Number;
      
      private var _saturation:Number;
      
      private var _brightness:Number;
      
      public function HSBColor(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN)
      {
         super();
         this.hue = param1;
         this.saturation = param2;
         this.brightness = param3;
      }
      
      public static function convertHSBtoRGB(param1:Number, param2:Number, param3:Number) : uint
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(param2 == 0)
         {
            _loc4_ = _loc5_ = _loc6_ = param3;
         }
         else
         {
            _loc7_ = param1 % 360 / 60;
            _loc8_ = int(_loc7_);
            _loc9_ = _loc7_ - _loc8_;
            _loc10_ = param3 * (1 - param2);
            _loc11_ = param3 * (1 - param2 * _loc9_);
            _loc12_ = param3 * (1 - param2 * (1 - _loc9_));
            switch(_loc8_)
            {
               case 0:
                  _loc4_ = param3;
                  _loc5_ = _loc12_;
                  _loc6_ = _loc10_;
                  break;
               case 1:
                  _loc4_ = _loc11_;
                  _loc5_ = param3;
                  _loc6_ = _loc10_;
                  break;
               case 2:
                  _loc4_ = _loc10_;
                  _loc5_ = param3;
                  _loc6_ = _loc12_;
                  break;
               case 3:
                  _loc4_ = _loc10_;
                  _loc5_ = _loc11_;
                  _loc6_ = param3;
                  break;
               case 4:
                  _loc4_ = _loc12_;
                  _loc5_ = _loc10_;
                  _loc6_ = param3;
                  break;
               case 5:
                  _loc4_ = param3;
                  _loc5_ = _loc10_;
                  _loc6_ = _loc11_;
            }
         }
         _loc4_ *= 255;
         _loc5_ *= 255;
         _loc6_ *= 255;
         return _loc4_ << 16 | _loc5_ << 8 | _loc6_;
      }
      
      public static function convertRGBtoHSB(param1:uint) : HSBColor
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = (param1 >> 16 & 0xFF) / 255;
         var _loc6_:Number = (param1 >> 8 & 0xFF) / 255;
         var _loc7_:Number = (param1 & 0xFF) / 255;
         var _loc8_:Number = Math.max(_loc5_,Math.max(_loc6_,_loc7_));
         var _loc9_:Number = Math.min(_loc5_,Math.min(_loc6_,_loc7_));
         var _loc10_:Number = _loc8_ - _loc9_;
         _loc4_ = _loc8_;
         if(_loc8_ != 0)
         {
            _loc3_ = _loc10_ / _loc8_;
         }
         else
         {
            _loc3_ = 0;
         }
         if(_loc3_ == 0)
         {
            _loc2_ = NaN;
         }
         else
         {
            if(_loc5_ == _loc8_)
            {
               _loc2_ = (_loc6_ - _loc7_) / _loc10_;
            }
            else if(_loc6_ == _loc8_)
            {
               _loc2_ = 2 + (_loc7_ - _loc5_) / _loc10_;
            }
            else if(_loc7_ == _loc8_)
            {
               _loc2_ = 4 + (_loc5_ - _loc6_) / _loc10_;
            }
            _loc2_ *= 60;
            if(_loc2_ < 0)
            {
               _loc2_ += 360;
            }
         }
         return new HSBColor(_loc2_,_loc3_,_loc4_);
      }
      
      public function get hue() : Number
      {
         return this._hue;
      }
      
      public function set hue(param1:Number) : void
      {
         this._hue = param1 % 360;
      }
      
      public function get saturation() : Number
      {
         return this._saturation;
      }
      
      public function set saturation(param1:Number) : void
      {
         this._saturation = param1;
      }
      
      public function get brightness() : Number
      {
         return this._brightness;
      }
      
      public function set brightness(param1:Number) : void
      {
         this._brightness = param1;
      }
   }
}

