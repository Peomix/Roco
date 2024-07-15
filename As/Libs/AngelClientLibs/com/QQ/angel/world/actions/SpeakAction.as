package com.QQ.angel.world.actions
{
   import com.QQ.angel.api.ui.IBubble;
   import com.QQ.angel.api.world.action.AbstractDurAction;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.ui.core.BubbleSkinType;
   import com.QQ.angel.world.impl.BaseObjectView;
   import com.QQ.angel.world.role.SimpleARoleView;
   
   public class SpeakAction extends AbstractDurAction
   {
      
      private static var count:int;
       
      
      protected var m_bubble:IBubble;
      
      protected var content:Object;
      
      private var m_itemView:BaseObjectView;
      
      private var m_role:SimpleARoleView;
      
      public function SpeakAction(param1:Object, param2:int = 4000)
      {
         super(ActionsIntro.SpeakAction,param2);
         this.content = param1;
      }
      
      protected function startNotRender(param1:Object) : Boolean
      {
         if(__global.SysAPI.getIsRender())
         {
            return false;
         }
         return true;
      }
      
      override public function start(param1:Object) : void
      {
         if(count >= 4)
         {
            return;
         }
         if(this.startNotRender(param1))
         {
            return;
         }
         this.m_itemView = (param1 as IMotionItem).getView() as BaseObjectView;
         this.m_role = this.m_itemView as SimpleARoleView;
         if(this.m_role != null)
         {
            if(!this.m_role.getRoleData().dazzleAvatar)
            {
               if(this.m_role.getRoleData().paopaoId != 0)
               {
                  this.m_role.setTalkBubbleVisible(true);
                  this.m_role.getTalkBubbleView().setChatStr(this.content);
               }
               else
               {
                  this.showDefaultBubble();
               }
            }
            else if(this.m_role.getRoleData().daPopup != 0)
            {
               this.m_role.setTalkBubbleVisible(true);
               this.m_role.getTalkBubbleView().setChatStr(this.content);
            }
            else
            {
               this.showDefaultBubble();
            }
         }
         else
         {
            this.showDefaultBubble();
         }
         setFinished(false);
         ++count;
      }
      
      private function showDefaultBubble() : void
      {
         this.m_bubble = this.m_itemView.getBubble();
         if(this.m_bubble == null)
         {
            this.m_bubble = __global.UI.createBubble(BubbleSkinType.ROLE_COMMON_TALK);
            this.m_itemView.setBubble(this.m_bubble);
         }
         if(this.content is String)
         {
            this.m_bubble.setContent(this.content);
         }
         else
         {
            this.m_bubble.setContent(this.content);
         }
         this.m_bubble.setVisible(true);
      }
      
      override public function giveUp() : Boolean
      {
         if(count > 0)
         {
            --count;
         }
         if(this.m_bubble != null)
         {
            this.m_bubble.setContent(null);
            this.m_bubble.setVisible(false);
            this.m_bubble = null;
         }
         else if(this.m_role != null)
         {
            this.m_role.setTalkBubbleVisible(false);
            this.m_role = null;
         }
         this.content = null;
         return true;
      }
   }
}
