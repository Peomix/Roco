package com.tencent.fge.foundation.diagnose
{
   import com.tencent.fge.foundation.diagnose.enum.DiagnoseDefine;
   import com.tencent.fge.foundation.log.client.Log;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Diagnose
   {
      
      private static var s_mapPatient:Dictionary = new Dictionary(true);
      
      private static var ms_allLog:String = "";
      
      private static var log:Log = new Log(Diagnose);
       
      
      private var m_patient:Object;
      
      private var m_patientName:String;
      
      private var m_patientAlias:String;
      
      public function Diagnose(param1:Object, param2:String)
      {
         var _loc3_:int = 0;
         super();
         this.m_patient = param1;
         this.m_patientAlias = param2;
         if(this.m_patient is String)
         {
            this.m_patientName = this.m_patient as String;
         }
         else
         {
            this.m_patientName = getQualifiedClassName(this.m_patient);
            _loc3_ = this.m_patientName.lastIndexOf("::");
            if(_loc3_ >= 0)
            {
               this.m_patientName = this.m_patientName.substring(_loc3_ + 2);
            }
         }
         registerDiagnose(param1,this);
      }
      
      private static function registerDiagnose(param1:Object, param2:Diagnose) : Diagnose
      {
         if(!s_mapPatient[param1])
         {
            s_mapPatient[param1] = param2;
         }
         else
         {
            Log.error("Diagnose.registerDiagnose","发现重复诊断用例的注册，将拒绝注册！");
         }
         return s_mapPatient[param1];
      }
      
      internal static function getDiagnose(param1:Object) : Diagnose
      {
         return s_mapPatient[param1];
      }
      
      public static function getLog(param1:Function = null, param2:String = null) : String
      {
         var _loc3_:RegExp = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         if(Boolean(param2) && 0 < param2.length)
         {
            _loc3_ = DiagnoseDefine.getCallerRegexp(param2);
            if((Boolean(_loc4_ = ms_allLog.match(_loc3_))) && 0 < _loc4_.length)
            {
               _loc5_ = "";
               _loc6_ = 0;
               while(_loc6_ < _loc4_.length)
               {
                  if(null != param1)
                  {
                     _loc5_ += _loc4_[_loc6_].replace(DiagnoseDefine.REGEXP,param1) + "\n";
                  }
                  else
                  {
                     _loc5_ += _loc4_[_loc6_] + "\n";
                  }
                  _loc6_++;
               }
               return _loc5_;
            }
            return "";
         }
         if(null != param1)
         {
            return ms_allLog.replace(DiagnoseDefine.REGEXP,param1);
         }
         return ms_allLog;
      }
      
      public static function plainTextReplacer(... rest) : String
      {
         var _loc2_:String = rest[0] as String;
         if(Boolean(_loc2_) && _loc2_.length > 0)
         {
            if(0 <= _loc2_.indexOf(DiagnoseDefine.CALLER) || 0 <= _loc2_.indexOf(DiagnoseDefine.CALLEE))
            {
               _loc2_ = _loc2_.replace(/,time:\d+:\d+(.\d+)*/g,"");
               _loc2_ = _loc2_.replace(/(\(name:)|(alias:)/g,"");
               _loc2_ = _loc2_.replace(",","(");
            }
            _loc2_ = _loc2_.substr(0,_loc2_.length - 1);
            _loc2_ = _loc2_.replace(DiagnoseDefine.REGEXP_PREHALF,"");
         }
         return _loc2_;
      }
      
      public static function defaultHtmlReplacer(... rest) : String
      {
         var _loc4_:String = null;
         var _loc2_:* = rest[0] as String;
         if(!_loc2_ || _loc2_.length <= 0)
         {
            return _loc2_;
         }
         var _loc3_:String = _loc2_;
         _loc2_ = _loc2_.substr(0,_loc2_.length - 1);
         _loc2_ = _loc2_.replace(DiagnoseDefine.REGEXP_PREHALF,"");
         if(0 <= _loc3_.indexOf(DiagnoseDefine.CALLER) || 0 <= _loc3_.indexOf(DiagnoseDefine.CALLEE))
         {
            _loc2_ = _loc2_.substr(1,_loc2_.length - 1);
            _loc2_ = _loc2_.substr(0,_loc2_.length - 1);
            _loc4_ = DiagnoseDefine.getAlias(_loc2_);
            _loc2_ = "<font color=\'#005599\'><u>" + "<a href=\'event:" + _loc2_ + "\'>" + _loc4_ + "</a></u></font>";
         }
         else if(0 <= _loc3_.indexOf(DiagnoseDefine.DID))
         {
            _loc2_ = "<font color=\'#009900\'>" + _loc2_ + "</font>";
         }
         else if(0 <= _loc3_.indexOf(DiagnoseDefine.DO))
         {
            _loc2_ = "<font color=\'#887700\'>" + _loc2_ + "</font>";
         }
         else if(0 <= _loc3_.indexOf(DiagnoseDefine.EXPECT))
         {
            _loc2_ = "<font color=\'#990000\'>" + _loc2_ + "</font>";
         }
         else if(0 <= _loc3_.indexOf(DiagnoseDefine.ERR))
         {
            _loc2_ = "<font color=\'#ff0000\'>" + _loc2_ + "</font>";
         }
         return _loc2_;
      }
      
      public function trace(param1:String, ... rest) : void
      {
         this.output("log",this.patientCallerLogName + "." + param1 + "(): " + rest);
      }
      
      public function error(param1:String, param2:String, ... rest) : void
      {
         var _loc4_:String = this.patientCallerLogName + DiagnoseDefine.getErrorText("【出错了！" + param2 + "】") + "。" + param1 + "(), " + rest;
         this.output("error",_loc4_);
      }
      
      public function begin(param1:String, param2:Object, param3:String, param4:String, ... rest) : void
      {
         var _loc6_:Diagnose = getDiagnose(param2);
         var _loc7_:* = this.patientCallerLogName + DiagnoseDefine.getDoText("【准备做：" + param3 + "】") + "，" + DiagnoseDefine.getExpectText("【期待着：" + param4 + "】") + "。";
         if(!_loc6_)
         {
            _loc7_ += "（关联对象：" + param2 + "），";
         }
         else
         {
            _loc7_ += "（关联对象：" + _loc6_.patientCalleeLogName + "），";
         }
         _loc7_ += param1 + "(), " + rest;
         this.output("begin",_loc7_);
      }
      
      public function end(param1:String, param2:String, ... rest) : void
      {
         var _loc4_:String = this.patientCallerLogName + DiagnoseDefine.getDidText("【已完成：" + param2 + "】") + "。" + param1 + "(), " + rest;
         this.output("end",_loc4_);
      }
      
      private function output(param1:String, param2:String) : void
      {
         var _loc3_:String = this.multiDgnTextToPlainText(param2);
         log.trace(param1,_loc3_);
         var _loc4_:* = DiagnoseDefine.LOG_PREFIX + "[" + this.getTimeString() + "][" + param1 + "]\t" + param2 + DiagnoseDefine.LOG_POSTFIX + "\n";
         ms_allLog += _loc4_;
      }
      
      private function get patientCallerLogName() : String
      {
         return DiagnoseDefine.getCallerText(this.m_patientName,this.m_patientAlias,this.getTimeString(false));
      }
      
      private function get patientCalleeLogName() : String
      {
         return DiagnoseDefine.getCalleeText(this.m_patientName,this.m_patientAlias,this.getTimeString(false));
      }
      
      private function getTimeString(param1:Boolean = true) : String
      {
         var _loc2_:Date = new Date();
         var _loc3_:String = _loc2_.hours + ":" + _loc2_.minutes + ":" + _loc2_.seconds;
         if(param1)
         {
            _loc3_ += "." + int(_loc2_.milliseconds);
         }
         return _loc3_;
      }
      
      private function multiDgnTextToPlainText(param1:String) : String
      {
         return param1.replace(DiagnoseDefine.REGEXP,plainTextReplacer);
      }
   }
}
