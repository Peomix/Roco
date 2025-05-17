package
{
   import com.QQ.angel.api.plug.IPlugLib;
   import com.QQ.angel.plugs.AutoExec.AutoExecPlugin;
   import flash.display.Sprite;
   
   public class AutoExecPluginLib extends Sprite implements IPlugLib
   {
      
      public function AutoExecPluginLib()
      {
         super();
      }
      
      public function getPlugClasses() : Array
      {
         return [AutoExecPlugin];
      }
   }
}

