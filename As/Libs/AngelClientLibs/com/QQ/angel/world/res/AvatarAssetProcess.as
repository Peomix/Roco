package com.QQ.angel.world.res
{
   import com.QQ.angel.world.render.BDFrame;
   import com.QQ.angel.world.render.MotionFCS;
   import com.QQ.angel.world.vo.Avatar;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AvatarAssetProcess
   {
       
      
      public function AvatarAssetProcess()
      {
         super();
      }
      
      public static function processToAvatar(param1:BitmapData, param2:int, param3:Dictionary, param4:Boolean) : Avatar
      {
         var _loc5_:MotionFCS = null;
         var _loc14_:Array = null;
         var _loc15_:Number = NaN;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:BDFrame = null;
         var _loc19_:BitmapData = null;
         var _loc20_:Rectangle = null;
         var _loc21_:int = 0;
         if(param1 == null)
         {
            param1 = new BitmapData(10,10,true,0);
            return makeEmptyAvater(param1,param2,param3);
         }
         (_loc5_ = param3[param2]).reset();
         var _loc6_:int = int(_loc5_.frameTimes.length);
         var _loc7_:Rectangle = new Rectangle(0,0,param1.width / _loc6_,param1.height >> 1);
         var _loc8_:Avatar;
         (_loc8_ = new Avatar()).motionType = param2;
         _loc8_.frames = [];
         var _loc9_:Rectangle = _loc7_.clone();
         var _loc10_:Point = new Point();
         var _loc11_:* = _loc7_.width >> 1;
         var _loc12_:Array = [];
         var _loc13_:int = 0;
         while(_loc13_ < 2)
         {
            _loc14_ = [];
            _loc15_ = _loc13_ * _loc7_.height;
            _loc16_ = _loc7_.height;
            _loc17_ = 0;
            while(_loc17_ < _loc6_)
            {
               _loc18_ = new BDFrame();
               _loc19_ = new BitmapData(int(_loc7_.width),int(_loc7_.height),true,0);
               _loc9_.x = _loc17_ * _loc7_.width;
               _loc9_.y = _loc15_;
               _loc19_.copyPixels(param1,_loc9_,_loc10_);
               _loc20_ = _loc19_.getColorBoundsRect(4278190080,0,false);
               if(!param4)
               {
                  _loc20_ = _loc7_.clone();
               }
               _loc21_ = _loc7_.height - _loc20_.y - _loc20_.height;
               _loc18_.offset = new Point(_loc20_.x - _loc11_,_loc21_);
               if(_loc21_ < _loc16_)
               {
                  _loc16_ = _loc21_;
               }
               _loc18_.img = new BitmapData(_loc20_.width,_loc20_.height);
               _loc18_.img.copyPixels(_loc19_,_loc20_,_loc10_);
               _loc19_.dispose();
               if(_loc5_ != null)
               {
                  _loc18_.times = _loc5_.getFrameTimes(_loc17_);
                  _loc18_.label = _loc5_.getFrameLabel(_loc17_);
                  _loc18_.offset.y += _loc5_.getYOffsets(_loc17_);
               }
               _loc14_.push(_loc18_);
               _loc17_++;
            }
            _loc12_.push(_loc16_);
            _loc8_.frames.push(_loc14_);
            _loc13_++;
         }
         _loc8_.frames.push(cloneFrames(_loc8_.frames[1],_loc12_[1]));
         _loc8_.frames.push(cloneFrames(_loc8_.frames[0],_loc12_[0]));
         param1.dispose();
         return _loc8_;
      }
      
      public static function makeEmptyAvater(param1:BitmapData, param2:int, param3:Dictionary) : Avatar
      {
         var _loc13_:Array = null;
         var _loc14_:Number = NaN;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:BDFrame = null;
         var _loc18_:BitmapData = null;
         var _loc19_:Rectangle = null;
         var _loc20_:int = 0;
         var _loc4_:MotionFCS;
         (_loc4_ = param3[param2]).reset();
         var _loc5_:int = int(_loc4_.frameTimes.length);
         var _loc6_:Rectangle = new Rectangle(0,0,2,2);
         var _loc7_:Avatar;
         (_loc7_ = new Avatar()).motionType = param2;
         _loc7_.frames = [];
         var _loc8_:Rectangle = _loc6_.clone();
         var _loc9_:Point = new Point();
         var _loc10_:* = _loc6_.width >> 1;
         var _loc11_:Array = [];
         var _loc12_:int = 0;
         while(_loc12_ < 2)
         {
            _loc13_ = [];
            _loc14_ = _loc12_ * _loc6_.height;
            _loc15_ = _loc6_.height;
            _loc16_ = 0;
            while(_loc16_ < _loc5_)
            {
               _loc17_ = new BDFrame();
               _loc18_ = new BitmapData(int(_loc6_.width),int(_loc6_.height),true,0);
               _loc8_.x = _loc16_ * _loc6_.width;
               _loc8_.y = _loc14_;
               _loc18_.copyPixels(param1,_loc8_,_loc9_);
               _loc19_ = new Rectangle(0,0,2,2);
               _loc20_ = 1;
               _loc17_.offset = new Point(0,0);
               if(_loc20_ < _loc15_)
               {
                  _loc15_ = _loc20_;
               }
               _loc17_.img = new BitmapData(_loc19_.width,_loc19_.height,true,0);
               _loc17_.img.copyPixels(_loc18_,_loc19_,_loc9_);
               _loc18_.dispose();
               if(_loc4_ != null)
               {
                  _loc17_.times = _loc4_.getFrameTimes(_loc16_);
                  _loc17_.label = _loc4_.getFrameLabel(_loc16_);
                  _loc17_.offset.y += _loc4_.getYOffsets(_loc16_);
               }
               _loc13_.push(_loc17_);
               _loc16_++;
            }
            _loc11_.push(_loc15_);
            _loc7_.frames.push(_loc13_);
            _loc12_++;
         }
         _loc7_.frames.push(cloneFrames(_loc7_.frames[1],_loc11_[1]));
         _loc7_.frames.push(cloneFrames(_loc7_.frames[0],_loc11_[0]));
         param1.dispose();
         return _loc7_;
      }
      
      public static function cloneFrames(param1:Array, param2:int) : Array
      {
         var _loc5_:BDFrame = null;
         var _loc6_:Point = null;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            (_loc6_ = (_loc5_ = param1[_loc4_] as BDFrame).offset).y = param2 - _loc6_.y - _loc5_.img.height;
            _loc3_.push(_loc5_.clone());
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
