package com.QQ.angel.world.scene.data
{
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.world.scene.IAngelSceneLogic;
   
   public class AngelSceneContext
   {
      
      public var model:AngelSceneModel;
      
      public var logic:IAngelSceneLogic;
      
      public var des:SceneDes;
      
      public var npcXML:String = "";
      
      public function AngelSceneContext(param1:SceneDes, param2:AngelSceneModel, param3:IAngelSceneLogic = null)
      {
         super();
         this.des = param1;
         this.model = param2;
         this.logic = param3;
      }
   }
}

