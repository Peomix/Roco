package com.QQ.angel.world.actions
{
   import com.QQ.angel.api.IResourceSysAPI;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.action.AbstractAction;
   import com.QQ.angel.api.world.role.ICursedDisplay;
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.api.world.scene.IElement;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.MagicSkillDes;
   import com.QQ.angel.data.entity.MakeMagicDes;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.world.effects.SmogEffect;
   import com.QQ.angel.world.events.EffectEvent;
   import com.QQ.angel.world.impl.SimpleCursedMCProxy;
   import com.QQ.angel.world.magic.ICanBeCursed;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class BeCursedAction extends AbstractAction
   {
       
      
      protected var element:IElement;
      
      protected var cursedDis:ICursedDisplay;
      
      protected var msDes:MagicSkillDes;
      
      protected var smogEffect:SmogEffect;
      
      protected var resSysApi:IResourceSysAPI;
      
      protected var hasSmog:Boolean = false;
      
      public function BeCursedAction(param1:Object)
      {
         super(ActionsIntro.BeCursedAction);
         this.msDes = param1 as MagicSkillDes;
         if(this.msDes == null)
         {
            this.msDes = (param1 as MakeMagicDes).useMS;
            if(__global.SysAPI.getIsRender())
            {
               this.hasSmog = true;
            }
         }
         if(this.msDes == null)
         {
            throw new Error("BeCursedAction构造函参数为NULL!");
         }
         this.resSysApi = __global.SysAPI.getResSysAPI();
      }
      
      protected function applyAction(param1:Event = null) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc4_:CFunction = null;
         if(this.msDes.id != -1)
         {
            _loc2_ = this.resSysApi.borrowObj(this.msDes.id);
         }
         else
         {
            _loc2_ = this.resSysApi.borrowObjByUrl(this.msDes.resSrc,this.msDes.name);
         }
         if(_loc2_ is CFunction)
         {
            _loc4_ = _loc2_ as CFunction;
            _loc2_.handler = this.curseResLoaded;
            return true;
         }
         var _loc3_:MovieClip = _loc2_ as MovieClip;
         this.cursedDis = new SimpleCursedMCProxy(_loc3_);
         if(_loc3_.hasOwnProperty("setBodyData"))
         {
            _loc3_["setBodyData"](this.element.getData());
         }
         this.curseResLoaded(null);
         return true;
      }
      
      protected function onSmogEffectEnd(param1:EffectEvent) : void
      {
         this.smogEffect.removeEventListener(EffectEvent.END_EFFECT,this.onSmogEffectEnd);
         (this.element.getView() as ICanBeCursed).delEffect(this.smogEffect.getDisplay());
         this.smogEffect = null;
      }
      
      protected function curseResLoaded(param1:LoadTaskEvent) : void
      {
         var _loc3_:RoleData = null;
         if(param1 != null)
         {
            this.applyAction();
            return;
         }
         var _loc2_:ICanBeCursed = this.element.getView() as ICanBeCursed;
         if(this.hasSmog)
         {
            this.smogEffect = new SmogEffect();
            this.smogEffect.addEventListener(EffectEvent.END_EFFECT,this.onSmogEffectEnd);
            _loc2_.addEffect(this.smogEffect.getDisplay());
            this.smogEffect.start();
         }
         _loc2_.setBodyVisible(false);
         _loc2_.setCursedDis(this.cursedDis);
         if(this.element is IRole && !this.msDes.isClient)
         {
            _loc3_ = this.element.getData() as RoleData;
            if(_loc3_ != null)
            {
               _loc3_.cursedType = this.msDes.id;
            }
         }
      }
      
      override public function start(param1:Object) : void
      {
         this.element = param1 as IElement;
         if(this.element == null)
         {
            trace("BeCursedAction不能施加在一个非IElement对象上!!");
            return;
         }
         if(this.applyAction())
         {
            setFinished(false);
         }
      }
      
      override public function giveUp() : Boolean
      {
         var _loc2_:RoleData = null;
         var _loc1_:ICanBeCursed = this.element.getView() as ICanBeCursed;
         if(this.element is IRole)
         {
            _loc2_ = this.element.getData() as RoleData;
            if(_loc2_ != null)
            {
               _loc2_.cursedType = 0;
            }
         }
         _loc1_.setCursedDis(null);
         _loc1_.setBodyVisible(true);
         if(this.cursedDis)
         {
            if(this.msDes.id != -1)
            {
               this.resSysApi.giveBackObj(this.msDes.id,this.cursedDis.display);
            }
            else
            {
               this.resSysApi.giveBackObjByUrl(this.msDes.resSrc,this.msDes.name,this.cursedDis.display);
            }
            this.cursedDis.unload();
            this.cursedDis = null;
            if(this.smogEffect != null)
            {
               this.onSmogEffectEnd(null);
            }
            this.msDes = null;
            this.element = null;
            this.resSysApi = null;
         }
         return true;
      }
   }
}
