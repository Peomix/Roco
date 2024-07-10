package
{
   import com.QQ.angel.api.plug.IPlugLib;
   import com.QQ.angel.plugs.Login.LoginPlugin;
   import flash.display.Sprite;
   
   public class LoginPluginLib extends Sprite implements IPlugLib
   {
       
      
      public function LoginPluginLib()
      {
         super();
      }
      
      public function getPlugClasses() : Array
      {
         return [LoginPlugin];
      }
   }
}
