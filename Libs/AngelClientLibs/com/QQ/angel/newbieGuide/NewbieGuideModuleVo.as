package com.QQ.angel.newbieGuide
{
   import com.QQ.angel.data.entity.NPCDialogData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class NewbieGuideModuleVo
   {
       
      
      public var moduleName:String;
      
      public var type:int = 1;
      
      public var targetId:String;
      
      public var taskId:int;
      
      public var desc:String = "";
      
      public var doWhat:String = "";
      
      public var mute:Boolean;
      
      public var sceneId:int;
      
      public var sceneVer:int;
      
      public var remoteKey:int;
      
      public var changeStepId:int;
      
      public var appUrl:String;
      
      public var tabIndex:int;
      
      public var arrow:int;
      
      public var actionEnabled:Boolean = true;
      
      public var maskType:int;
      
      public var interactiveRect:String = "";
      
      public var maskRect:Rectangle;
      
      public var tooltip:String;
      
      public var hasBtn:Boolean;
      
      public var triggerNextStep:Boolean = true;
      
      public var autoRect:Boolean = true;
      
      public var npcdialogData:NPCDialogData;
      
      public var point:Point;
      
      public var width:int;
      
      public var height:int;
      
      public var checkTime:int = 0;
      
      public var combatId:int;
      
      public var combatName:String;
      
      public function NewbieGuideModuleVo()
      {
         super();
      }
   }
}
