package com.QQ.angel.world.script.impl
{
   public class BaseSwitchScript extends AbstractScript
   {
       
      
      protected var xml:XML;
      
      protected var caseXML:Object;
      
      public function BaseSwitchScript(param1:String)
      {
         super(param1);
      }
      
      override public function execute(param1:XML) : void
      {
         var caseXMLList:XMLList = null;
         var itemXML:XML = null;
         var i:int = 0;
         var xml:XML = param1;
         this.xml = xml;
         this.caseXML = {};
         caseXMLList = xml.Case.(@value != "");
         i = 0;
         while(i < caseXMLList.length())
         {
            itemXML = caseXMLList[i];
            this.caseXML[itemXML.@value] = itemXML.children()[0];
            i++;
         }
         itemXML = xml.Default[0];
         if(itemXML != null)
         {
            this.caseXML["default"] = itemXML.children()[0];
         }
      }
      
      public function onReturnCase(param1:int) : void
      {
         var _loc2_:XML = this.caseXML[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this.caseXML["default"];
         }
         noticeComplete(_loc2_);
      }
      
      override public function dispose() : void
      {
         this.xml = null;
         this.caseXML = null;
         super.dispose();
      }
   }
}
