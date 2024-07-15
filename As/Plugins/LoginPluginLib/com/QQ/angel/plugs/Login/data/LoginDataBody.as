package com.QQ.angel.plugs.Login.data
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class LoginDataBody implements IExternalizable
   {
       
      
      public var roomID:uint = 4385;
      
      public var key:String = "102s1df2asd15asd4f";
      
      public function LoginDataBody()
      {
         super();
      }
      
      public function readExternal(param1:IDataInput) : void
      {
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeShort(roomID);
         DEFINE.WriteChars(param1,key,DEFINE.L_SESSIONKEY);
      }
   }
}
