package com.QQ.angel.world.role
{
   import com.QQ.angel.world.render.BDRenderPlayer;
   import flash.display.Sprite;
   
   public class AvatarBodyContainer extends Sprite
   {
      
      public var topLayer:Sprite;
      
      public var midLayer:Sprite;
      
      public var groundLayer:Sprite;
      
      public var body:BDRenderPlayer;
      
      public function AvatarBodyContainer()
      {
         super();
         this.groundLayer = new Sprite();
         addChild(this.groundLayer);
         this.midLayer = new Sprite();
         addChild(this.midLayer);
         this.topLayer = new Sprite();
         addChild(this.topLayer);
      }
      
      public function setBody(param1:BDRenderPlayer) : void
      {
         this.body = param1;
         this.midLayer.addChild(param1);
      }
   }
}

