package
{
   import com.QQ.angel.api.plug.IPlugLib;
   import com.QQ.angel.plugs.Effect.EffectPlugin;
   import flash.display.Sprite;
   
   public class EffectPluginLib extends Sprite implements IPlugLib
   {
      
      public function EffectPluginLib()
      {
         super();
      }
      
      public function getPlugClasses() : Array
      {
         return [EffectPlugin];
      }
   }
}

