package com.QQ.angel.world.script.syscmd
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.extensions.IChatExtension;
   import flash.text.TextField;
   
   public class SystemCommandListener implements IChatExtension
   {
      
      public static const CMD_START:String = "AngelSystemCommand";
       
      
      protected var isSysCmdMode:Boolean = false;
      
      protected var input:TextField;
      
      public function SystemCommandListener()
      {
         super();
      }
      
      protected function checkSysCmd(param1:String) : Boolean
      {
         if(param1 == CMD_START)
         {
            this.isSysCmdMode = true;
            return true;
         }
         return false;
      }
      
      protected function cmd_install(param1:Array) : void
      {
         var _loc2_:String = param1[1];
         var _loc3_:String = param1[2];
         if(_loc2_ == null || _loc3_ == null)
         {
            return;
         }
         if(_loc3_.indexOf("https://") == -1 && _loc3_.indexOf("http://") == -1)
         {
            _loc3_ = DEFINE.COMM_ROOT + "plugin/" + _loc3_;
         }
         __global.SysAPI.getPlugSysAPI().loadAndInstallPlug(_loc3_,_loc2_);
      }
      
      protected function cmd_exit(param1:Array) : void
      {
         this.isSysCmdMode = false;
      }
      
      protected function receiveSysCmd(param1:String) : Boolean
      {
         var _loc2_:Array = param1.split(" ");
         var _loc3_:String = _loc2_[0];
         switch(_loc3_)
         {
            case "install":
               this.cmd_install(_loc2_);
               return true;
            case "exit":
               this.cmd_exit(_loc2_);
               return true;
            default:
               this.isSysCmdMode = false;
               return false;
         }
      }
      
      public function init(param1:TextField) : void
      {
      }
      
      public function acceptWords(param1:String) : Boolean
      {
         if(this.isSysCmdMode)
         {
            return this.receiveSysCmd(param1);
         }
         return this.checkSysCmd(param1);
      }
   }
}
