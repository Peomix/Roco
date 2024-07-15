package com.QQ.angel.utils
{
   import com.QQ.angel.common.__global;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class Tween
   {
      
      public static var root:DisplayObject;
      
      private static var list:Dictionary = new Dictionary();
      
      private static var len:int;
       
      
      public function Tween()
      {
         super();
      }
      
      public static function to(param1:Object, param2:Number, param3:Object, param4:Object = null, param5:Function = null, param6:Number = 0) : void
      {
         var _loc9_:String = null;
         if(list[param1] != null)
         {
            for(_loc9_ in param3)
            {
               setValue(param1,_loc9_,param3[_loc9_]);
            }
            --len;
         }
         if(param4 == null)
         {
            param4 = {};
            for(_loc9_ in param3)
            {
               param4[_loc9_] = param1[_loc9_];
            }
         }
         var _loc7_:Object = {};
         var _loc8_:int = param2 * 24;
         for(_loc9_ in param3)
         {
            _loc7_[_loc9_] = (param3[_loc9_] - param1[_loc9_]) / _loc8_;
         }
         list[param1] = {
            "count":_loc8_,
            "fromVars":param4,
            "target":param1,
            "targetVars":param3,
            "perVars":_loc7_,
            "callBack":param5,
            "delay":param6 * 24
         };
         ++len;
         startMotion();
      }
      
      private static function startMotion() : void
      {
         if(root == null)
         {
            root = __global.SysAPI.getUISysAPI().getPlugContainer();
         }
         if(len > 0)
         {
            root.removeEventListener(Event.ENTER_FRAME,enterFrame);
            root.addEventListener(Event.ENTER_FRAME,enterFrame);
         }
         else
         {
            root.removeEventListener(Event.ENTER_FRAME,enterFrame);
         }
      }
      
      private static function enterFrame(param1:Event = null) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         for(_loc2_ in list)
         {
            _loc3_ = list[_loc2_];
            --_loc3_.delay;
            if(_loc3_.delay < 0)
            {
               --_loc3_.count;
               if(_loc3_.count <= 0)
               {
                  for(_loc4_ in _loc3_.targetVars)
                  {
                     setValue(_loc3_.target,_loc4_,_loc3_.targetVars[_loc4_]);
                  }
                  if(_loc3_.callBack)
                  {
                     _loc3_.callBack();
                  }
                  delete list[_loc2_];
                  --len;
                  startMotion();
               }
               else
               {
                  for(_loc4_ in _loc3_.targetVars)
                  {
                     _loc3_.fromVars[_loc4_] += _loc3_.perVars[_loc4_];
                     setValue(_loc3_.target,_loc4_,_loc3_.fromVars[_loc4_]);
                  }
               }
            }
         }
      }
      
      protected static function setValue(param1:Object, param2:String, param3:Number) : void
      {
         var _loc4_:MovieClip = null;
         switch(param2)
         {
            case "currentFrame":
               if(_loc4_ = param1 as MovieClip)
               {
                  trace("set currentFrame:" + int(param3));
                  _loc4_.gotoAndStop(int(param3));
               }
               else
               {
                  param1[param2] = param3;
               }
               break;
            default:
               param1[param2] = param3;
         }
      }
   }
}
