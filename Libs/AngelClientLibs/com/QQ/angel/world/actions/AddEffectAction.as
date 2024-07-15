package com.QQ.angel.world.actions
{
   import com.QQ.angel.api.IResourceSysAPI;
   import com.QQ.angel.api.world.action.AbstractDurAction;
   import com.QQ.angel.api.world.scene.IElement;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.MagicSkillDes;
   import com.QQ.angel.data.entity.MakeMagicDes;
   import com.QQ.angel.utils.LocalFile;
   import com.QQ.angel.world.magic.ICanAddedEffect;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class AddEffectAction extends AbstractDurAction
   {
       
      
      protected var element:IElement;
      
      protected var mvDes:Object;
      
      protected var mv:MovieClip;
      
      protected var resSysApi:IResourceSysAPI;
      
      protected var eContainer:ICanAddedEffect;
      
      protected var _isDazzle:Boolean;
      
      public function AddEffectAction(param1:Object)
      {
         if(param1 is MakeMagicDes)
         {
            this.mvDes = (param1 as MakeMagicDes).useMS;
         }
         else
         {
            this.mvDes = param1;
         }
         super(ActionsIntro.AddEffectAction,this.mvDes.dur);
         this._isDazzle = param1.isDazzle;
         this.resSysApi = __global.SysAPI.getResSysAPI();
      }
      
      protected function applyAction(param1:Event = null) : Boolean
      {
         this.eContainer = this.element.getView() as ICanAddedEffect;
         if(this.mvDes.hasOwnProperty("mc"))
         {
            this.mv = this.mvDes.mc;
         }
         else
         {
            this.mv = this.resSysApi.borrowObj(this.mvDes.id,this.mvDes is MagicSkillDes ? 0 : 1) as MovieClip;
         }
         if(this._isDazzle)
         {
            this.mv.y = -35;
         }
         else
         {
            this.mv.y = 0;
         }
         this.eContainer.addEffect(this.mv);
         return true;
      }
      
      override public function start(param1:Object) : void
      {
         this.element = param1 as IElement;
         if(this.element == null)
         {
            throw new Error("AddEffectAction不能施加在一个非IElement对象上!!");
         }
         if(this.applyAction())
         {
            setFinished(false);
         }
      }
      
      override public function giveUp() : Boolean
      {
         if(this.mv != null)
         {
            if(this.mvDes.hasOwnProperty("giveBackFun"))
            {
               if(this.mvDes.giveBackFun != null)
               {
                  this.mvDes.giveBackFun(this.mv);
               }
            }
            else
            {
               this.eContainer.delEffect(this.mv);
               LocalFile.STOPContainer(this.mv);
               this.resSysApi.giveBackObj(this.mvDes.id,this.mv,this.mvDes is MagicSkillDes ? 0 : 1);
            }
         }
         this.mv = null;
         this.mvDes = null;
         this.element = null;
         this.resSysApi = null;
         this.eContainer = null;
         return super.giveUp();
      }
   }
}
