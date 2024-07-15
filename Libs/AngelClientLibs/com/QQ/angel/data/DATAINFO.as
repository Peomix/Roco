package com.QQ.angel.data
{
   import com.QQ.angel.data.dataInfoAngel.DataInfoAdapter_AVATAR;
   import com.QQ.angel.data.dataInfoAngel.DataInfoAdapter_MAIL_LIST;
   import com.QQ.angel.data.dataInfoAngel.DataInfoAdapter_SERVER_TIME;
   import com.QQ.angel.data.dataInfoAngel.DataInfoAdapter_SERVER_TIME_STAMP;
   import com.QQ.angel.data.dataInfoAngel.DataInfoAdapter_TASK_CONDITION_STATUS;
   import com.QQ.angel.data.dataInfoAngel.DataInfoAdapter_TASK_STATUS;
   
   public class DATAINFO
   {
      
      public static const DATAINFO_ARRAY:Array = [DataInfoAdapter_MAIL_LIST,DataInfoAdapter_TASK_STATUS,DataInfoAdapter_TASK_CONDITION_STATUS,DataInfoAdapter_AVATAR,DataInfoAdapter_SERVER_TIME,DataInfoAdapter_SERVER_TIME_STAMP];
       
      
      public function DATAINFO()
      {
         super();
      }
   }
}
