package com.QQ.angel.ui.core
{
   import flash.display.Sprite;
   
   public class DefaultNumberMC extends Sprite
   {
       
      
      protected var bitMCS:Array;
      
      public function DefaultNumberMC(param1:int = 5)
      {
         var _loc3_:DMCNums = null;
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.bitMCS = [];
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = new DMCNums();
            _loc3_.x = _loc2_ * 23;
            _loc3_.visible = false;
            addChild(_loc3_);
            this.bitMCS.push(_loc3_);
            _loc2_++;
         }
      }
      
      public function setValue(param1:int, param2:Boolean = false) : void
      {
         var _loc5_:DMCNums = null;
         var _loc6_:int = 0;
         var _loc8_:DMCNums = null;
         var _loc3_:* = param1 + "";
         var _loc4_:int = _loc3_.length;
         var _loc7_:int = 0;
         while(_loc7_ < this.bitMCS.length)
         {
            _loc8_ = this.bitMCS[_loc7_];
            if(_loc7_ < _loc4_)
            {
               _loc8_.visible = true;
               if(param2)
               {
                  if(_loc5_ != null)
                  {
                     _loc8_.setNextNumMC(_loc5_,_loc6_);
                     _loc5_ = _loc8_;
                  }
                  else
                  {
                     _loc5_ = _loc8_;
                  }
                  _loc6_ = int(_loc3_.charAt(_loc7_));
               }
               else
               {
                  _loc8_.setValue(int(_loc3_.charAt(_loc7_)),false);
               }
            }
            else
            {
               _loc8_.visible = false;
            }
            _loc7_++;
         }
         if(_loc5_ != null)
         {
            _loc5_.setValue(_loc6_,true);
         }
      }
   }
}
