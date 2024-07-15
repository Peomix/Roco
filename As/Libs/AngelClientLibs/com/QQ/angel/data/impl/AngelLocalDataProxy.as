package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   
   public class AngelLocalDataProxy implements IDataProxy
   {
       
      
      private var _so:SharedObject;
      
      private var _currUin:uint;
      
      public function AngelLocalDataProxy(param1:uint)
      {
         var uin:uint = param1;
         super();
         try
         {
            this._currUin = uin;
            this._so = SharedObject.getLocal(Constants.SO_DATA + "_" + this._currUin);
         }
         catch(error:Error)
         {
            _so = null;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         if(this._so == null || rest.length != 2)
         {
            return false;
         }
         this._so.data[rest[0]] = rest[1];
         return true;
      }
      
      public function select(... rest) : Object
      {
         if(this._so == null || rest.length != 1)
         {
            return false;
         }
         return this._so.data[rest[0]];
      }
      
      public function update(... rest) : Boolean
      {
         if(this._so == null)
         {
            return false;
         }
         return this._so.flush() == SharedObjectFlushStatus.FLUSHED;
      }
      
      public function deleted(... rest) : Boolean
      {
         if(this._so == null || rest.length != 1)
         {
            return false;
         }
         if(this._so.data[rest[0]] != null)
         {
            delete this._so.data[rest[0]];
            return true;
         }
         return false;
      }
      
      public function clear() : void
      {
         if(this._so != null)
         {
            this._so.clear();
         }
      }
      
      public function getName() : String
      {
         return Constants.SO_DATA;
      }
   }
}
