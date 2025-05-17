package com.tencent.fge.utils
{
   import flash.system.ApplicationDomain;
   import flash.utils.getQualifiedClassName;
   
   public class ClassUtil
   {
      
      private var m_fullName:String = "";
      
      private var m_name:String = "";
      
      private var m_domain:ApplicationDomain;
      
      public function ClassUtil(param1:Object, param2:ApplicationDomain = null)
      {
         super();
         this.m_fullName = getQualifiedClassName(param1);
         var _loc3_:int = int(this.m_fullName.lastIndexOf("::"));
         this.m_name = this.m_fullName.substring(_loc3_ + 2);
         this.m_domain = param2;
         if(this.m_domain == null)
         {
            this.m_domain = ApplicationDomain.currentDomain;
         }
      }
      
      public static function getFullName(param1:Object) : String
      {
         return getQualifiedClassName(param1);
      }
      
      public static function getName(param1:Object) : String
      {
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:int = int(_loc2_.lastIndexOf("::"));
         return _loc2_.substring(_loc3_ + 2);
      }
      
      public function get fullValue() : String
      {
         return this.m_fullName;
      }
      
      public function get value() : String
      {
         return this.m_name;
      }
      
      public function getDefinition() : Class
      {
         return this.m_domain.getDefinition(this.m_fullName) as Class;
      }
   }
}

