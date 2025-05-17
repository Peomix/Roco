package com.QQ.angel.world.role
{
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.res.IResAdapter;
   
   public class RMArgsContext
   {
      
      public var roleLogicCls:Class;
      
      public var roleViewCls:Class;
      
      public var avataAdapter:IResAdapter;
      
      public var dazzleAvatarAdapter:IResAdapter;
      
      public var petLogicCls:Class;
      
      public var petViewCls:Class;
      
      public var wearEffectCls:Class;
      
      public var petSkinAdapter:IResAdapter;
      
      public var roleSys:IAngelRoleSystem;
      
      public var magicDProxy:IDataProxy;
      
      public var spiritDesProxy:IDataProxy;
      
      public var guardianPetSkinAdapter:IResAdapter;
      
      public var guardianPetDesProxy:IDataProxy;
      
      public function RMArgsContext()
      {
         super();
      }
   }
}

