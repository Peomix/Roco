package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.data.entity.FurnitureDes;
   import flash.utils.Dictionary;
   
   public class FurnitureDataProxy implements IDataProxy
   {
      
      private var xml:XML;
      
      private var dic:Dictionary;
      
      public function FurnitureDataProxy(param1:Object)
      {
         super();
         this.dic = new Dictionary();
         this.processXML(param1);
      }
      
      private function processXML(param1:Object) : void
      {
         var _loc3_:FurnitureDes = null;
         this.xml = param1 is XML ? param1 as XML : new XML(param1);
         var _loc2_:int = 0;
         while(_loc2_ < this.xml.Furniture.length())
         {
            _loc3_ = new FurnitureDes();
            _loc3_.read(this.xml.Furniture[_loc2_] as XML);
            this.dic[_loc3_.id] = _loc3_;
            _loc2_++;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         if(rest != null && rest.length == 0)
         {
            return this.dic;
         }
         if(rest != null && rest[0] is int)
         {
            return this.dic[rest[0]];
         }
         return null;
      }
      
      public function update(... rest) : Boolean
      {
         return false;
      }
      
      public function deleted(... rest) : Boolean
      {
         return false;
      }
      
      public function clear() : void
      {
      }
      
      public function getName() : String
      {
         return Constants.FURNITURE_LIST_DATA;
      }
   }
}

