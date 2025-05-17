package com.tencent.fge.engine.ui.keyboard
{
   import flash.utils.Dictionary;
   
   public class KeyCode
   {
      
      private static var ms_mapCode2Name:Dictionary;
      
      private static var ms_mapName2Code:Dictionary;
      
      public static var A:uint = 65;
      
      public static var ALTERNATE:uint = 18;
      
      public static var B:uint = 66;
      
      public static var BACKQUOTE:uint = 192;
      
      public static var BACKSLASH:uint = 220;
      
      public static var BACKSPACE:uint = 8;
      
      public static var C:uint = 67;
      
      public static var CAPS_LOCK:uint = 20;
      
      public static var COMMA:uint = 188;
      
      public static var COMMAND:uint = 15;
      
      public static var CONTROL:uint = 17;
      
      public static var D:uint = 68;
      
      public static var DELETE:uint = 46;
      
      public static var DOWN:uint = 40;
      
      public static var E:uint = 69;
      
      public static var END:uint = 35;
      
      public static var ENTER:uint = 13;
      
      public static var EQUAL:uint = 187;
      
      public static var ESCAPE:uint = 27;
      
      public static var F:uint = 70;
      
      public static var F1:uint = 112;
      
      public static var F10:uint = 121;
      
      public static var F11:uint = 122;
      
      public static var F12:uint = 123;
      
      public static var F13:uint = 124;
      
      public static var F14:uint = 125;
      
      public static var F15:uint = 126;
      
      public static var F2:uint = 113;
      
      public static var F3:uint = 114;
      
      public static var F4:uint = 115;
      
      public static var F5:uint = 116;
      
      public static var F6:uint = 117;
      
      public static var F7:uint = 118;
      
      public static var F8:uint = 119;
      
      public static var F9:uint = 120;
      
      public static var G:uint = 71;
      
      public static var H:uint = 72;
      
      public static var HOME:uint = 36;
      
      public static var I:uint = 73;
      
      public static var INSERT:uint = 45;
      
      public static var J:uint = 74;
      
      public static var K:uint = 75;
      
      public static var KEYNAME_BEGIN:String = "Begin";
      
      public static var KEYNAME_BREAK:String = "Break";
      
      public static var KEYNAME_CLEARDISPLAY:String = "ClrDsp";
      
      public static var KEYNAME_CLEARLINE:String = "ClrLn";
      
      public static var KEYNAME_DELETE:String = "Delete";
      
      public static var KEYNAME_DELETECHAR:String = "DelChr";
      
      public static var KEYNAME_DELETELINE:String = "DelLn";
      
      public static var KEYNAME_DOWNARROW:String = "Down";
      
      public static var KEYNAME_END:String = "End";
      
      public static var KEYNAME_EXECUTE:String = "Exec";
      
      public static var KEYNAME_F1:String = "F1";
      
      public static var KEYNAME_F10:String = "F10";
      
      public static var KEYNAME_F11:String = "F11";
      
      public static var KEYNAME_F12:String = "F12";
      
      public static var KEYNAME_F13:String = "F13";
      
      public static var KEYNAME_F14:String = "F14";
      
      public static var KEYNAME_F15:String = "F15";
      
      public static var KEYNAME_F16:String = "F16";
      
      public static var KEYNAME_F17:String = "F17";
      
      public static var KEYNAME_F18:String = "F18";
      
      public static var KEYNAME_F19:String = "F19";
      
      public static var KEYNAME_F2:String = "F2";
      
      public static var KEYNAME_F20:String = "F20";
      
      public static var KEYNAME_F21:String = "F21";
      
      public static var KEYNAME_F22:String = "F22";
      
      public static var KEYNAME_F23:String = "F23";
      
      public static var KEYNAME_F24:String = "F24";
      
      public static var KEYNAME_F25:String = "F25";
      
      public static var KEYNAME_F26:String = "F26";
      
      public static var KEYNAME_F27:String = "F27";
      
      public static var KEYNAME_F28:String = "F28";
      
      public static var KEYNAME_F29:String = "F29";
      
      public static var KEYNAME_F3:String = "F3";
      
      public static var KEYNAME_F30:String = "F30";
      
      public static var KEYNAME_F31:String = "F31";
      
      public static var KEYNAME_F32:String = "F32";
      
      public static var KEYNAME_F33:String = "F33";
      
      public static var KEYNAME_F34:String = "F34";
      
      public static var KEYNAME_F35:String = "F35";
      
      public static var KEYNAME_F4:String = "F4";
      
      public static var KEYNAME_F5:String = "F5";
      
      public static var KEYNAME_F6:String = "F6";
      
      public static var KEYNAME_F7:String = "F7";
      
      public static var KEYNAME_F8:String = "F8";
      
      public static var KEYNAME_F9:String = "F9";
      
      public static var KEYNAME_FIND:String = "Find";
      
      public static var KEYNAME_HELP:String = "Help";
      
      public static var KEYNAME_HOME:String = "Home";
      
      public static var KEYNAME_INSERT:String = "Insert";
      
      public static var KEYNAME_INSERTCHAR:String = "InsChr";
      
      public static var KEYNAME_INSERTLINE:String = "InsLn";
      
      public static var KEYNAME_LEFTARROW:String = "Left";
      
      public static var KEYNAME_MENU:String = "Menu";
      
      public static var KEYNAME_MODESWITCH:String = "ModeSw";
      
      public static var KEYNAME_NEXT:String = "Next";
      
      public static var KEYNAME_PAGEDOWN:String = "PgDn";
      
      public static var KEYNAME_PAGEUP:String = "PgUp";
      
      public static var KEYNAME_PAUSE:String = "Pause";
      
      public static var KEYNAME_PREV:String = "Prev";
      
      public static var KEYNAME_PRINT:String = "Print";
      
      public static var KEYNAME_PRINTSCREEN:String = "PrntScrn";
      
      public static var KEYNAME_REDO:String = "Redo";
      
      public static var KEYNAME_RESET:String = "Reset";
      
      public static var KEYNAME_RIGHTARROW:String = "Right";
      
      public static var KEYNAME_SCROLLLOCK:String = "ScrlLck";
      
      public static var KEYNAME_SELECT:String = "Select";
      
      public static var KEYNAME_STOP:String = "Stop";
      
      public static var KEYNAME_SYSREQ:String = "SysReq";
      
      public static var KEYNAME_SYSTEM:String = "Sys";
      
      public static var KEYNAME_UNDO:String = "Undo";
      
      public static var KEYNAME_UPARROW:String = "Up";
      
      public static var KEYNAME_USER:String = "User";
      
      public static var L:uint = 76;
      
      public static var LEFT:uint = 37;
      
      public static var LEFTBRACKET:uint = 219;
      
      public static var M:uint = 77;
      
      public static var MINUS:uint = 189;
      
      public static var N:uint = 78;
      
      public static var NUMBER_0:uint = 48;
      
      public static var NUMBER_1:uint = 49;
      
      public static var NUMBER_2:uint = 50;
      
      public static var NUMBER_3:uint = 51;
      
      public static var NUMBER_4:uint = 52;
      
      public static var NUMBER_5:uint = 53;
      
      public static var NUMBER_6:uint = 54;
      
      public static var NUMBER_7:uint = 55;
      
      public static var NUMBER_8:uint = 56;
      
      public static var NUMBER_9:uint = 57;
      
      public static var NUMPAD:uint = 21;
      
      public static var NUMPAD_0:uint = 96;
      
      public static var NUMPAD_1:uint = 97;
      
      public static var NUMPAD_2:uint = 98;
      
      public static var NUMPAD_3:uint = 99;
      
      public static var NUMPAD_4:uint = 100;
      
      public static var NUMPAD_5:uint = 101;
      
      public static var NUMPAD_6:uint = 102;
      
      public static var NUMPAD_7:uint = 103;
      
      public static var NUMPAD_8:uint = 104;
      
      public static var NUMPAD_9:uint = 105;
      
      public static var NUMPAD_ADD:uint = 107;
      
      public static var NUMPAD_DECIMAL:uint = 110;
      
      public static var NUMPAD_DIVIDE:uint = 111;
      
      public static var NUMPAD_ENTER:uint = 108;
      
      public static var NUMPAD_MULTIPLY:uint = 106;
      
      public static var NUMPAD_SUBTRACT:uint = 109;
      
      public static var O:uint = 79;
      
      public static var P:uint = 80;
      
      public static var PAGE_DOWN:uint = 34;
      
      public static var PAGE_UP:uint = 33;
      
      public static var PERIOD:uint = 190;
      
      public static var Q:uint = 81;
      
      public static var QUOTE:uint = 222;
      
      public static var R:uint = 82;
      
      public static var RIGHT:uint = 39;
      
      public static var RIGHTBRACKET:uint = 221;
      
      public static var S:uint = 83;
      
      public static var SEMICOLON:uint = 186;
      
      public static var SHIFT:uint = 16;
      
      public static var SLASH:uint = 191;
      
      public static var SPACE:uint = 32;
      
      public static var T:uint = 84;
      
      public static var TAB:uint = 9;
      
      public static var U:uint = 85;
      
      public static var UP:uint = 38;
      
      public static var V:uint = 86;
      
      public static var W:uint = 87;
      
      public static var X:uint = 88;
      
      public static var Y:uint = 89;
      
      public static var Z:uint = 90;
      
      public function KeyCode()
      {
         super();
      }
      
      public static function keyCode2Name(param1:uint) : String
      {
         if(ms_mapCode2Name == null)
         {
            ms_mapCode2Name = mapKeyCode2Name();
         }
         return ms_mapCode2Name[param1];
      }
      
      public static function keyName2Code(param1:String) : uint
      {
         if(ms_mapName2Code == null)
         {
            ms_mapName2Code = mapKeyName2Code();
         }
         return ms_mapName2Code[param1];
      }
      
      private static function mapKeyCode2Name() : Dictionary
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc1_:String = "abcdefghijklmnopqrstuvwxyz";
         var _loc2_:String = "1234567890";
         var _loc3_:Dictionary = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = _loc1_.charAt(_loc4_);
            _loc6_ = _loc5_.toLocaleUpperCase();
            _loc3_[KeyCode[_loc6_]] = _loc5_;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc7_ = _loc2_.charAt(_loc4_);
            _loc3_[KeyCode["NUMBER_" + _loc7_]] = _loc7_;
            _loc3_[KeyCode["NUMPAD_" + _loc7_]] = _loc7_;
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function mapKeyName2Code() : Dictionary
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc1_:String = "abcdefghijklmnopqrstuvwxyz";
         var _loc2_:String = "1234567890";
         var _loc3_:Dictionary = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = _loc1_.charAt(_loc4_);
            _loc6_ = _loc5_.toLocaleUpperCase();
            _loc3_[_loc5_] = KeyCode[_loc6_];
            _loc3_[_loc6_] = KeyCode[_loc6_];
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc7_ = _loc2_.charAt(_loc4_);
            _loc3_[_loc7_] = KeyCode["NUMBER_" + _loc7_];
            _loc4_++;
         }
         return _loc3_;
      }
   }
}

