package com.tencent.fge.utils
{
   import com.tencent.fge.foundation.log.client.Log;
   
   public class Invoke
   {
      
      protected static const version:String = "1.0.0";
      
      protected static const author:String = "slicoltang,slicol@qq.com";
      
      protected static const copyright:String = "腾讯计算机系统有限公司";
       
      
      private var m_fun:Function;
      
      private var m_arg:Object;
      
      public function Invoke(param1:Function, ... rest)
      {
         this.m_arg = new Object();
         super();
         this.m_fun = param1;
         this.m_arg = rest;
      }
      
      public function set arg(param1:Object) : void
      {
         if(param1 is Array)
         {
            this.m_arg = param1;
         }
         else
         {
            this.m_arg = [param1];
         }
      }
      
      public function get arg() : Object
      {
         return this.m_arg;
      }
      
      public function get fun() : Function
      {
         return this.m_fun;
      }
      
      public function release() : void
      {
         this.m_fun = null;
         this.m_arg = null;
      }
      
      public function execute() : void
      {
         var fun:Function = this.m_fun;
         var arg:Array = this.m_arg as Array;
         if(fun == null)
         {
            return;
         }
         try
         {
            switch(arg.length)
            {
               case 0:
                  fun();
                  break;
               case 1:
                  fun(arg[0]);
                  break;
               case 2:
                  fun(arg[0],arg[1]);
                  break;
               case 3:
                  fun(arg[0],arg[1],arg[2]);
                  break;
               case 4:
                  fun(arg[0],arg[1],arg[2],arg[3]);
                  break;
               case 5:
                  fun(arg[0],arg[1],arg[2],arg[3],arg[4]);
                  break;
               case 6:
                  fun(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5]);
                  break;
               case 7:
                  fun(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5],arg[6]);
                  break;
               case 8:
                  fun(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5],arg[6],arg[7]);
                  break;
               case 9:
                  fun(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5],arg[6],arg[7],arg[8]);
                  break;
               case 10:
                  fun(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5],arg[6],arg[7],arg[8],arg[9]);
            }
         }
         catch(error:Error)
         {
            Log.fatal("Invoke.execute",error.message + "\n" + error.getStackTrace());
         }
      }
   }
}
