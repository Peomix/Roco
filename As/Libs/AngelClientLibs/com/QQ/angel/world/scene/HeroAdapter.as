package com.QQ.angel.world.scene
{
   import com.QQ.angel.api.display.IDisplay;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.IRoleSysAPI;
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.world.events.ElementEvent;
   import com.QQ.angel.world.role.IAngelRoleSystem;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class HeroAdapter extends EventDispatcher implements IHero
   {
       
      
      protected var hero:IRole;
      
      protected var heroDisplay:IDisplay;
      
      protected var roleSys:IAngelRoleSystem;
      
      protected var isMe:Boolean = false;
      
      public function HeroAdapter()
      {
         super();
      }
      
      public function bindParams(param1:IRoleSysAPI = null, param2:IRole = null) : void
      {
         if(param1 != null)
         {
            this.roleSys = param1 as IAngelRoleSystem;
            this.hero = param2;
            if(this.hero == null)
            {
               this.hero = param1.getMainRole();
               this.isMe = true;
            }
            this.heroDisplay = this.hero.getRoleView();
            return;
         }
         this.hero = null;
         this.roleSys = null;
         this.heroDisplay = null;
         this.isMe = false;
      }
      
      public function changePosition(param1:int, param2:Array, param3:Boolean = true) : void
      {
         if(this.isMe == false)
         {
            throw new Error("[HeroAdapter] 不能控制非自己玩家的移动方式!");
         }
         var _loc4_:Point = param2[param2.length - 1];
         if(param1 <= 10)
         {
            this.moveTo(_loc4_);
            return;
         }
         if(this.roleSys == null)
         {
            return;
         }
         this.setPos(_loc4_,param3);
         this.roleSys.bcRolePos(param1,param2);
      }
      
      public function moveTo(param1:Point) : void
      {
         if(this.roleSys == null)
         {
            return;
         }
         this.roleSys.mainRoleWalk(param1);
      }
      
      public function closedExec(param1:Point, param2:int, param3:CFunction) : void
      {
         __global.heroClosedExec(param1,param2,param3);
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(this.heroDisplay != null)
         {
            this.heroDisplay.visible = param1;
         }
      }
      
      public function getVisible() : Boolean
      {
         if(this.heroDisplay != null)
         {
            return this.heroDisplay.visible;
         }
         return false;
      }
      
      public function getPos() : Point
      {
         if(this.hero != null)
         {
            return this.hero.getPosition();
         }
         return null;
      }
      
      public function setPos(param1:Point, param2:Boolean = true) : void
      {
         var _loc3_:ElementEvent = null;
         if(this.hero != null)
         {
            this.hero.setPosition(param1);
            if(param2)
            {
               _loc3_ = new ElementEvent(ElementEvent.ON_NEW_POSITION);
               this.hero.dispatchEvent(_loc3_);
            }
         }
      }
      
      public function getMotionType() : int
      {
         if(this.hero != null)
         {
            return this.hero.getMotionType();
         }
         return 0;
      }
      
      public function getData() : Object
      {
         if(this.hero != null)
         {
            return this.hero.getData();
         }
         return {};
      }
      
      public function addListener(param1:String, param2:Function) : void
      {
         if(param2 == null || this.heroDisplay == null)
         {
            return;
         }
         trace("[HeroAdapter] 事件[" + param1 + "]添加侦听成功!");
         this.heroDisplay.addEventListener(param1,param2);
      }
      
      public function removeListener(param1:String, param2:Function) : void
      {
         if(param2 == null || this.heroDisplay == null)
         {
            return;
         }
         trace("[HeroAdapter] 事件[" + param1 + "]删除侦听成功!");
         this.heroDisplay.removeEventListener(param1,param2);
      }
      
      public function dispose() : void
      {
         this.hero = null;
         this.roleSys = null;
         this.heroDisplay = null;
         this.isMe = false;
      }
   }
}
