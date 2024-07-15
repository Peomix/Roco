package CallbackUtil
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class CallbackCenter
   {
      
      public static const EVENT_OK:int = 0;
      
      private static var CALLBACK_ENTER_FRAME:int;
      
      private static var CALLBACK_STAGE_MOUSE_DOWN:int;
      
      private static var CALLBACK_STAGE_MOUSE_UP:int;
      
      private static var CALLBACK_STAGE_MOUSE_MOVE:int;
      
      private static var CALLBACK_STAGE_MOUSE_WHEEL:int;
      
      private static var CALLBACK_STAGE_MOUSE_LEAVE:int;
      
      private static var CALLBACK_STAGE_MOUSE_DOWN_CAPTURE:int;
      
      private static var CALLBACK_STAGE_MOUSE_UP_CAPTURE:int;
      
      private static var CALLBACK_KEY_DOWN:int;
      
      private static var CALLBACK_KEY_UP:int;
      
      private static var s_CallbackCenter_Dict:Dictionary;
      
      private static var s_stage:Stage;
       
      
      public function CallbackCenter()
      {
         super();
      }
      
      public static function notifyEvent(param1:int, param2:Object = null, param3:Object = null) : void
      {
         var _loc5_:CallBackObj = null;
         var _loc6_:int = 0;
         var _loc4_:Array;
         if(_loc4_ = s_CallbackCenter_Dict[param1])
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               (_loc5_ = CallBackObj(_loc4_[_loc6_])).func(param1,param2,param3,_loc5_.obj);
               if(_loc6_ < _loc4_.length && _loc5_ == _loc4_[_loc6_])
               {
                  _loc6_++;
               }
            }
            _loc4_ = null;
         }
      }
      
      public static function getCallBackIndex(param1:int, param2:Function, param3:Object = null) : int
      {
         var _loc7_:CallBackObj = null;
         if(!s_CallbackCenter_Dict)
         {
            return -1;
         }
         var _loc4_:Array = s_CallbackCenter_Dict[param1] as Array;
         var _loc5_:int = -1;
         var _loc6_:int = 0;
         for each(_loc7_ in _loc4_)
         {
            if(_loc7_.func == param2 && _loc7_.obj == param3)
            {
               _loc5_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public static function registerCallBackAt(param1:int, param2:Function, param3:Object, param4:int) : void
      {
         if(s_CallbackCenter_Dict[param1] == null)
         {
            s_CallbackCenter_Dict[param1] = new Array();
         }
         var _loc5_:Array = s_CallbackCenter_Dict[param1] as Array;
         var _loc6_:CallBackObj = new CallBackObj(param2,param3);
         _loc5_.splice(param4,0,_loc6_);
      }
      
      public static function registerCallBack(param1:int, param2:Function, param3:Object = null) : void
      {
         if(s_CallbackCenter_Dict[param1] == null)
         {
            s_CallbackCenter_Dict[param1] = new Array();
         }
         var _loc4_:Array = s_CallbackCenter_Dict[param1] as Array;
         var _loc5_:CallBackObj = new CallBackObj(param2,param3);
         _loc4_.push(_loc5_);
      }
      
      public static function unregisterCallBack(param1:int, param2:Function, param3:Object = null) : void
      {
         var _loc7_:CallBackObj = null;
         if(!s_CallbackCenter_Dict)
         {
            return;
         }
         var _loc4_:Array = s_CallbackCenter_Dict[param1] as Array;
         var _loc5_:int = -1;
         var _loc6_:int = 0;
         for each(_loc7_ in _loc4_)
         {
            if(_loc7_.func == param2 && _loc7_.obj == param3)
            {
               _loc5_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         if(_loc5_ != -1)
         {
            _loc4_.splice(_loc5_,1);
         }
      }
      
      public static function init(param1:Stage, param2:Object) : void
      {
         s_stage = param1;
         s_CallbackCenter_Dict = new Dictionary();
         CALLBACK_ENTER_FRAME = param2[Event.ENTER_FRAME] != undefined ? int(param2[Event.ENTER_FRAME]) : -1;
         CALLBACK_STAGE_MOUSE_DOWN = param2[MouseEvent.MOUSE_DOWN] != undefined ? int(param2[MouseEvent.MOUSE_DOWN]) : -1;
         CALLBACK_STAGE_MOUSE_UP = param2[MouseEvent.MOUSE_UP] != undefined ? int(param2[MouseEvent.MOUSE_UP]) : -1;
         CALLBACK_STAGE_MOUSE_MOVE = param2[MouseEvent.MOUSE_MOVE] != undefined ? int(param2[MouseEvent.MOUSE_MOVE]) : -1;
         CALLBACK_STAGE_MOUSE_WHEEL = param2[MouseEvent.MOUSE_WHEEL] != undefined ? int(param2[MouseEvent.MOUSE_WHEEL]) : -1;
         CALLBACK_STAGE_MOUSE_LEAVE = param2[Event.MOUSE_LEAVE] != undefined ? int(param2[Event.MOUSE_LEAVE]) : -1;
         CALLBACK_STAGE_MOUSE_DOWN_CAPTURE = param2[MouseEvent.MOUSE_DOWN + "Capture"] != undefined ? int(param2[MouseEvent.MOUSE_DOWN + "Capture"]) : -1;
         CALLBACK_STAGE_MOUSE_UP_CAPTURE = param2[MouseEvent.MOUSE_UP + "Capture"] != undefined ? int(param2[MouseEvent.MOUSE_UP + "Capture"]) : -1;
         CALLBACK_KEY_DOWN = param2[KeyboardEvent.KEY_DOWN] != undefined ? int(param2[KeyboardEvent.KEY_DOWN]) : -1;
         CALLBACK_KEY_UP = param2[KeyboardEvent.KEY_UP] != undefined ? int(param2[KeyboardEvent.KEY_UP]) : -1;
         if(CALLBACK_ENTER_FRAME >= 0)
         {
            param1.addEventListener(Event.ENTER_FRAME,onEnterFrame);
         }
         if(CALLBACK_STAGE_MOUSE_DOWN >= 0)
         {
            param1.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,false);
         }
         if(CALLBACK_STAGE_MOUSE_UP >= 0)
         {
            param1.addEventListener(MouseEvent.MOUSE_UP,onMouseUp,false);
         }
         if(CALLBACK_STAGE_MOUSE_MOVE >= 0)
         {
            param1.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
         }
         if(CALLBACK_STAGE_MOUSE_WHEEL >= 0)
         {
            param1.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
         }
         if(CALLBACK_STAGE_MOUSE_LEAVE >= 0)
         {
            param1.addEventListener(Event.MOUSE_LEAVE,onMouseLeave);
         }
         if(CALLBACK_STAGE_MOUSE_DOWN_CAPTURE >= 0)
         {
            param1.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown_Capture,true);
         }
         if(CALLBACK_STAGE_MOUSE_UP_CAPTURE >= 0)
         {
            param1.addEventListener(MouseEvent.MOUSE_UP,onMouseUp_Capture,true);
         }
         if(CALLBACK_KEY_DOWN >= 0)
         {
            param1.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
         }
         if(CALLBACK_KEY_UP >= 0)
         {
            param1.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
         }
      }
      
      private static function onMouseDown(param1:MouseEvent) : void
      {
         notifyEvent(CALLBACK_STAGE_MOUSE_DOWN,param1);
      }
      
      private static function onMouseUp(param1:MouseEvent) : void
      {
         notifyEvent(CALLBACK_STAGE_MOUSE_UP,param1);
      }
      
      private static function onMouseDown_Capture(param1:MouseEvent) : void
      {
         notifyEvent(CALLBACK_STAGE_MOUSE_DOWN_CAPTURE,param1);
      }
      
      private static function onMouseUp_Capture(param1:MouseEvent) : void
      {
         notifyEvent(CALLBACK_STAGE_MOUSE_UP_CAPTURE,param1);
      }
      
      private static function onMouseMove(param1:MouseEvent) : void
      {
         notifyEvent(CALLBACK_STAGE_MOUSE_MOVE,param1);
      }
      
      private static function onMouseWheel(param1:MouseEvent) : void
      {
         notifyEvent(CALLBACK_STAGE_MOUSE_WHEEL,param1);
      }
      
      private static function onMouseLeave(param1:Event) : void
      {
         notifyEvent(CALLBACK_STAGE_MOUSE_LEAVE,param1);
      }
      
      private static function onEnterFrame(param1:Event) : void
      {
         notifyEvent(CALLBACK_ENTER_FRAME,param1);
      }
      
      private static function onKeyDown(param1:KeyboardEvent) : void
      {
         notifyEvent(CALLBACK_KEY_DOWN,param1);
      }
      
      private static function onKeyUp(param1:KeyboardEvent) : void
      {
         notifyEvent(CALLBACK_KEY_UP,param1);
      }
      
      public static function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         if(s_CallbackCenter_Dict)
         {
            for each(_loc2_ in s_CallbackCenter_Dict)
            {
               _loc1_ = int(_loc2_.length);
               while(_loc1_--)
               {
                  _loc2_[_loc1_].dispose();
                  _loc2_[_loc1_] = null;
               }
            }
         }
         s_CallbackCenter_Dict = null;
         if(s_stage)
         {
            if(CALLBACK_ENTER_FRAME >= 0)
            {
               s_stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
            }
            if(CALLBACK_STAGE_MOUSE_DOWN >= 0)
            {
               s_stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,false);
            }
            if(CALLBACK_STAGE_MOUSE_UP >= 0)
            {
               s_stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp,false);
            }
            if(CALLBACK_STAGE_MOUSE_MOVE >= 0)
            {
               s_stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
            }
            if(CALLBACK_STAGE_MOUSE_WHEEL >= 0)
            {
               s_stage.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
            }
            if(CALLBACK_STAGE_MOUSE_LEAVE >= 0)
            {
               s_stage.removeEventListener(Event.MOUSE_LEAVE,onMouseLeave);
            }
            if(CALLBACK_STAGE_MOUSE_DOWN_CAPTURE >= 0)
            {
               s_stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown_Capture,true);
            }
            if(CALLBACK_STAGE_MOUSE_UP_CAPTURE >= 0)
            {
               s_stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp_Capture,true);
            }
            if(CALLBACK_KEY_DOWN >= 0)
            {
               s_stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
            }
            if(CALLBACK_KEY_UP >= 0)
            {
               s_stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
            }
            s_stage = null;
         }
      }
   }
}
