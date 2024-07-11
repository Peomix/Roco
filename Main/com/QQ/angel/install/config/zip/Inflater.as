package com.QQ.angel.install.config.zip
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class Inflater
   {
      
      private static const LENS:Array = [3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43,51,59,67,83,99,115,131,163,195,227,258];
      
      private static const MAXDCODES:int = 30;
      
      private static const MAXBITS:int = 15;
      
      private static const MAXLCODES:int = 286;
      
      private static const MAXCODES:int = MAXLCODES + MAXDCODES;
      
      private static const FIXLCODES:int = 288;
      
      private static const LEXT:Array = [0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0];
      
      private static const DISTS:Array = [1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385,513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577];
      
      private static const DEXT:Array = [0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13];
       
      
      private var lencode:Object;
      
      private var bitcnt:int;
      
      private var bitbuf:int;
      
      private var incnt:uint;
      
      private var inbuf:ByteArray;
      
      private var distcode:Object;
      
      public function Inflater()
      {
         super();
      }
      
      public function inflate(param1:ByteArray) : uint
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         incnt = bitbuf = bitcnt = 0;
         var _loc2_:int = 0;
         do
         {
            _loc3_ = bits(1);
            if((_loc4_ = bits(2)) == 0)
            {
               stored(param1);
            }
            else
            {
               if(_loc4_ == 3)
               {
                  throw new Error("invalid block type (type == 3)",-1);
               }
               lencode = {
                  "count":[],
                  "symbol":[]
               };
               distcode = {
                  "count":[],
                  "symbol":[]
               };
               if(_loc4_ == 1)
               {
                  constructFixedTables();
               }
               else if(_loc4_ == 2)
               {
                  _loc2_ = constructDynamicTables();
               }
               if(_loc2_ != 0)
               {
                  return _loc2_;
               }
               _loc2_ = codes(param1);
            }
            if(_loc2_ != 0)
            {
               break;
            }
         }
         while(!_loc3_);
         
         return _loc2_;
      }
      
      private function constructFixedTables() : void
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < 144)
         {
            _loc1_[_loc2_] = 8;
            _loc2_++;
         }
         while(_loc2_ < 256)
         {
            _loc1_[_loc2_] = 9;
            _loc2_++;
         }
         while(_loc2_ < 280)
         {
            _loc1_[_loc2_] = 7;
            _loc2_++;
         }
         while(_loc2_ < FIXLCODES)
         {
            _loc1_[_loc2_] = 8;
            _loc2_++;
         }
         construct(lencode,_loc1_,FIXLCODES);
         _loc2_ = 0;
         while(_loc2_ < MAXDCODES)
         {
            _loc1_[_loc2_] = 5;
            _loc2_++;
         }
         construct(distcode,_loc1_,MAXDCODES);
      }
      
      private function stored(param1:ByteArray) : void
      {
         bitbuf = 0;
         bitcnt = 0;
         if(incnt + 4 > inbuf.length)
         {
            throw new Error("available inflate data did not terminate",2);
         }
         var _loc2_:uint = uint(inbuf[incnt++]);
         _loc2_ |= inbuf[incnt++] << 8;
         if(inbuf[incnt++] != (~_loc2_ & 255) || inbuf[incnt++] != (~_loc2_ >> 8 & 255))
         {
            throw new Error("stored block length did not match one\'s complement",-2);
         }
         if(incnt + _loc2_ > inbuf.length)
         {
            throw new Error("available inflate data did not terminate",2);
         }
         while(_loc2_--)
         {
            param1[param1.length] = inbuf[incnt++];
         }
      }
      
      public function setInput(param1:ByteArray) : void
      {
         inbuf = param1;
         inbuf.endian = Endian.LITTLE_ENDIAN;
      }
      
      private function constructDynamicTables() : int
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = [16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15];
         var _loc3_:int = bits(5) + 257;
         var _loc4_:int = bits(5) + 1;
         var _loc5_:int = bits(4) + 4;
         if(_loc3_ > MAXLCODES || _loc4_ > MAXDCODES)
         {
            throw new Error("dynamic block code description: too many length or distance codes",-3);
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc1_[_loc2_[_loc6_]] = bits(3);
            _loc6_++;
         }
         while(_loc6_ < 19)
         {
            _loc1_[_loc2_[_loc6_]] = 0;
            _loc6_++;
         }
         var _loc7_:int;
         if((_loc7_ = construct(lencode,_loc1_,19)) != 0)
         {
            throw new Error("dynamic block code description: code lengths codes incomplete",-4);
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_ + _loc4_)
         {
            if((_loc8_ = decode(lencode)) < 16)
            {
               var _loc10_:*;
               _loc1_[_loc10_ = _loc6_++] = _loc8_;
            }
            else
            {
               _loc9_ = 0;
               if(_loc8_ == 16)
               {
                  if(_loc6_ == 0)
                  {
                     throw new Error("dynamic block code description: repeat lengths with no first length",-5);
                  }
                  _loc9_ = int(_loc1_[_loc6_ - 1]);
                  _loc8_ = 3 + bits(2);
               }
               else if(_loc8_ == 17)
               {
                  _loc8_ = 3 + bits(3);
               }
               else
               {
                  _loc8_ = 11 + bits(7);
               }
               if(_loc6_ + _loc8_ > _loc3_ + _loc4_)
               {
                  throw new Error("dynamic block code description: repeat more than specified lengths",-6);
               }
               while(_loc8_--)
               {
                  _loc1_[_loc10_ = _loc6_++] = _loc9_;
               }
            }
         }
         if((_loc7_ = construct(lencode,_loc1_,_loc3_)) < 0 || _loc7_ > 0 && _loc3_ - lencode.count[0] != 1)
         {
            throw new Error("dynamic block code description: invalid literal/length code lengths",-7);
         }
         if((_loc7_ = construct(distcode,_loc1_.slice(_loc3_),_loc4_)) < 0 || _loc7_ > 0 && _loc4_ - distcode.count[0] != 1)
         {
            throw new Error("dynamic block code description: invalid distance code lengths",-8);
         }
         return _loc7_;
      }
      
      private function bits(param1:int) : int
      {
         var _loc2_:* = bitbuf;
         while(bitcnt < param1)
         {
            if(incnt == inbuf.length)
            {
               throw new Error("available inflate data did not terminate",2);
            }
            _loc2_ |= inbuf[incnt++] << bitcnt;
            bitcnt += 8;
         }
         bitbuf = _loc2_ >> param1;
         bitcnt -= param1;
         return _loc2_ & (1 << param1) - 1;
      }
      
      private function construct(param1:Object, param2:Array, param3:int) : int
      {
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ <= MAXBITS)
         {
            param1.count[_loc5_] = 0;
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < param3)
         {
            ++param1.count[param2[_loc6_]];
            _loc6_++;
         }
         if(param1.count[0] == param3)
         {
            return 0;
         }
         var _loc7_:* = 1;
         _loc5_ = 1;
         while(_loc5_ <= MAXBITS)
         {
            if((_loc7_ = (_loc7_ <<= 1) - param1.count[_loc5_]) < 0)
            {
               return _loc7_;
            }
            _loc5_++;
         }
         _loc4_[1] = 0;
         _loc5_ = 1;
         while(_loc5_ < MAXBITS)
         {
            _loc4_[_loc5_ + 1] = _loc4_[_loc5_] + param1.count[_loc5_];
            _loc5_++;
         }
         _loc6_ = 0;
         while(_loc6_ < param3)
         {
            if(param2[_loc6_] != 0)
            {
               var _loc8_:*;
               param1.symbol[_loc8_ = _loc4_[param2[_loc6_]]++] = _loc6_;
            }
            _loc6_++;
         }
         return _loc7_;
      }
      
      private function decode(param1:Object) : int
      {
         var _loc6_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 1;
         while(_loc5_ <= MAXBITS)
         {
            _loc2_ |= bits(1);
            _loc6_ = int(param1.count[_loc5_]);
            if(_loc2_ < _loc3_ + _loc6_)
            {
               return param1.symbol[_loc4_ + (_loc2_ - _loc3_)];
            }
            _loc4_ += _loc6_;
            _loc3_ += _loc6_;
            _loc3_ <<= 1;
            _loc2_ <<= 1;
            _loc5_++;
         }
         return -9;
      }
      
      private function codes(param1:ByteArray) : int
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         while(true)
         {
            _loc2_ = decode(lencode);
            if(_loc2_ < 0)
            {
               break;
            }
            if(_loc2_ < 256)
            {
               param1[param1.length] = _loc2_;
            }
            else if(_loc2_ > 256)
            {
               _loc2_ -= 257;
               if(_loc2_ >= 29)
               {
                  throw new Error("invalid literal/length or distance code in fixed or dynamic block",-9);
               }
               _loc3_ = LENS[_loc2_] + bits(LEXT[_loc2_]);
               _loc2_ = decode(distcode);
               if(_loc2_ < 0)
               {
                  return _loc2_;
               }
               if((_loc4_ = DISTS[_loc2_] + bits(DEXT[_loc2_])) > param1.length)
               {
                  throw new Error("distance is too far back in fixed or dynamic block",-10);
               }
               while(_loc3_--)
               {
                  param1[param1.length] = param1[param1.length - _loc4_];
               }
            }
            if(_loc2_ == 256)
            {
               return 0;
            }
         }
         return _loc2_;
      }
   }
}
