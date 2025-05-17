package com.QQ.angel.ui.core.namebg
{
   import com.QQ.angel.ui.core.Animation;
   import flash.display.DisplayObject;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class BgLoader extends Animation
   {
      
      private var m_appDomain:ApplicationDomain;
      
      public function BgLoader(param1:Number = 0, param2:Number = 0)
      {
         super(param1,param2);
         this.m_appDomain = new ApplicationDomain();
         task.context = new LoaderContext(false,this.m_appDomain);
      }
      
      public function getLoaderInstance(param1:String) : DisplayObject
      {
         var _loc2_:Class = this.m_appDomain.getDefinition(param1) as Class;
         return new _loc2_() as DisplayObject;
      }
   }
}

