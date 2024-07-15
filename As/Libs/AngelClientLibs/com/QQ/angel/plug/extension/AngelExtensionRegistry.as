package com.QQ.angel.plug.extension
{
   import com.QQ.angel.api.plug.extension.IExtension;
   import com.QQ.angel.api.plug.extension.IExtensionPoint;
   import com.QQ.angel.api.plug.extension.IExtensionRegistry;
   import flash.utils.Dictionary;
   
   public class AngelExtensionRegistry implements IExtensionRegistry
   {
       
      
      protected var epList:Array;
      
      protected var epMap:Dictionary;
      
      protected var extensions:Dictionary;
      
      public function AngelExtensionRegistry()
      {
         super();
         this.epList = [];
         this.epMap = new Dictionary();
         this.extensions = new Dictionary();
      }
      
      protected function addEP(param1:IExtensionPoint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IExtension = null;
         this.epList.push(param1);
         this.epMap[param1.getID()] = param1;
         var _loc2_:String = param1.getID();
         var _loc3_:Array = this.extensions[_loc2_];
         if(_loc3_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if((_loc5_ = _loc3_[_loc4_]) != null)
               {
                  param1.addExtension(_loc5_);
               }
               _loc4_++;
            }
            this.extensions[_loc2_] = null;
            delete this.extensions[_loc2_];
         }
      }
      
      protected function removeEP(param1:IExtensionPoint) : void
      {
         var _loc2_:int = this.epList.indexOf(param1);
         var _loc3_:String = param1.getID();
         if(_loc2_ != -1)
         {
            this.epList.splice(_loc2_,1);
         }
         this.epMap[_loc3_] = null;
         delete this.epMap[_loc3_];
      }
      
      public function addExtensionPoint(param1:IExtensionPoint) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = param1.getID();
         if(this.epMap[_loc2_] != null)
         {
            throw new Error("已经有一个ID为" + _loc2_ + "的扩展点存在!");
         }
         this.addEP(param1);
      }
      
      public function removeExtensionPoint(param1:IExtensionPoint) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.removeEP(param1);
      }
      
      public function getExtensionPoint(param1:String) : IExtensionPoint
      {
         return this.epMap[param1];
      }
      
      public function addExtension(param1:String, param2:IExtension) : void
      {
         var _loc4_:Array = null;
         var _loc3_:IExtensionPoint = this.epMap[param1];
         if(_loc3_ != null)
         {
            _loc3_.addExtension(param2);
         }
         else
         {
            if((_loc4_ = this.extensions[param1]) == null)
            {
               this.extensions[param1] = _loc4_ = [];
            }
            if(_loc4_.indexOf(param2) != -1)
            {
               return;
            }
            _loc4_.push(param2);
         }
      }
      
      public function removeExtension(param1:String, param2:IExtension) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:IExtensionPoint = this.epMap[param1];
         if(_loc3_ != null)
         {
            _loc3_.removeExtension(param2);
         }
         else
         {
            if((_loc4_ = this.extensions[param1]) == null)
            {
               return;
            }
            if((_loc5_ = _loc4_.indexOf(param2)) != -1)
            {
               _loc4_.splice(_loc5_,1);
            }
         }
      }
      
      public function getExtensionPoints() : Array
      {
         return this.epList;
      }
   }
}
