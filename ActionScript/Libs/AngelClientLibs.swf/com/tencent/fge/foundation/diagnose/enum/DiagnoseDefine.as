package com.tencent.fge.foundation.diagnose.enum
{
   public class DiagnoseDefine
   {
      
      public static const CALLER:String = "caller";
      
      public static const CALLEE:String = "callee";
      
      public static const NAME:String = "name";
      
      public static const ALIAS:String = "alias";
      
      public static const TIME:String = "time";
      
      public static const DO:String = "do";
      
      public static const EXPECT:String = "exp";
      
      public static const DID:String = "did";
      
      public static const ERR:String = "err";
      
      public static const DIAGNOSE_PREFIX_REGEXP_STRING:String = "\\{dgn\\.";
      
      public static const HOLDER_MIDFIX_REGEXP_STRING:String = "\\:";
      
      public static const DIAGNOSE_POSTFIX_REGEXP_STRING:String = "\\}";
      
      public static const REGEXP:RegExp = new RegExp(/{dgn\..*?}/gi);
      
      public static const REGEXP_PREHALF:RegExp = new RegExp(/{dgn\..*?:/gi);
      
      public static var LOG_PREFIX:String = "[b]";
      
      public static var LOG_POSTFIX:String = "[e]";
      
      public static var LOG_PREFIX_REGEXP_STRING:String = "\\[b\\]";
      
      public static var LOG_POSTFIX_REGEXP_STRING:String = "\\[e\\]";
      
      public function DiagnoseDefine()
      {
         super();
      }
      
      public static function getDiagnoseText(param1:String, param2:String) : String
      {
         return "{dgn." + param1 + ":" + param2 + "}";
      }
      
      public static function getCallerText(param1:String, param2:String, param3:String) : String
      {
         return getDiagnoseText(CALLER,"(" + NAME + ":" + param1 + "," + ALIAS + ":" + param2 + "," + TIME + ":" + param3 + ")");
      }
      
      public static function getCalleeText(param1:String, param2:String, param3:String) : String
      {
         return getDiagnoseText(CALLEE,"(" + NAME + ":" + param1 + "," + ALIAS + ":" + param2 + "," + TIME + ":" + param3 + ")");
      }
      
      public static function getDoText(param1:String) : String
      {
         return getDiagnoseText(DO,param1);
      }
      
      public static function getExpectText(param1:String) : String
      {
         return getDiagnoseText(EXPECT,param1);
      }
      
      public static function getDidText(param1:String) : String
      {
         return getDiagnoseText(DID,param1);
      }
      
      public static function getErrorText(param1:String) : String
      {
         return getDiagnoseText(ERR,param1);
      }
      
      public static function getCallerRegexp(param1:String) : RegExp
      {
         return new RegExp(DiagnoseDefine.LOG_PREFIX_REGEXP_STRING + ".*(" + DiagnoseDefine.DIAGNOSE_PREFIX_REGEXP_STRING + DiagnoseDefine.CALLER + ":\\(" + NAME + ":" + param1 + ").*" + DiagnoseDefine.LOG_POSTFIX_REGEXP_STRING,"gi");
      }
      
      public static function getAlias(param1:String) : String
      {
         var _loc2_:RegExp = new RegExp("(.*" + NAME + ":.*\\," + ALIAS + ":)|(," + TIME + ":.*)","g");
         return param1.replace(_loc2_,"");
      }
   }
}

