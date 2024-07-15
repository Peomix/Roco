package com.QQ.angel.actions.ui
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   
   public class ShowItemAwards
   {
       
      
      public function ShowItemAwards(param1:Array, param2:CFunction = null)
      {
         super();
         if(param2)
         {
            __global.showItemPanel(param1,param2.handler);
         }
         else
         {
            __global.showItemPanel(param1);
         }
      }
   }
}
