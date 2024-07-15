package com.QQ.angel.plug
{
   public class PluginSetting
   {
      
      public static const SYNC_LOAD:int = 0;
      
      public static const ASYN_LOAD:int = 1;
      
      public static const LIBS_LOAD:int = 2;
       
      
      public var name:String;
      
      public var plugName:String;
      
      public var plugLabel:String;
      
      public var plugSrc:String;
      
      public var cmdType:String;
      
      public var params:String;
      
      public var require:Array;
      
      public var loadType:int = 0;
      
      public var step:int = 0;
      
      public var domain:String;
      
      public var version:String;
      
      public function PluginSetting()
      {
         super();
      }
   }
}
