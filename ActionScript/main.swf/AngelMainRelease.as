package//文档类，加载swf自动实例化
{
   import com.QQ.angel.install.config.AngelLibsLoader;
   import com.QQ.angel.install.config.GlobalConfig;
   import com.QQ.angel.install.config.QueueConfs;
   import com.QQ.angel.install.config.VerConfigLoader;
   import com.QQ.angel.install.logging.SocketLogger;
   import com.QQ.angel.install.logging.log;
   import com.QQ.angel.install.ui.Billboard;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.system.Security;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class AngelMainRelease extends Sprite
   {
      
      protected var libsLoader:AngelLibsLoader;
      
      protected var bb:Billboard;
      
      protected var timeline:int = 0;
      
      protected var loadingUI:InstallLoadingBar;
      
      private var IS_DEBUG:Boolean = false;
      
      protected var angelMainApp:Object;
      
      protected var globalConf:GlobalConfig;
      
      protected var verConf:VerConfigLoader;
      
      public function AngelMainRelease()
      {
         super();
         loadVerConf();
         timeline = getTimer();
         var _loc1_:Object = stage.loaderInfo.parameters;
         if(_loc1_ == null)
         {
            _loc1_ = {};
         }
         SocketLogger.getInstance(_loc1_["angel_uin"],_loc1_["angel_key"]);
         Security.allowDomain("*");
      }
      

      protected function onAllConfsLoaded(param1:Object) : void
      {
         var _loc2_:Object = null;
         globalConf.setAllConfs(param1);
         trace("[AngelAppInstall] 程序相关的配置文件加载完毕!!");
         libsLoader = new AngelLibsLoader(loadingUI);
         for each(_loc2_ in globalConf.getLibsPath(0))
         {
            if(Boolean(_loc2_) && _loc2_.src != null)
            {
               _loc2_.src = addFileVersion(_loc2_.src);
            }
         }
         libsLoader.loadLibs(globalConf.getLibsPath(0),onLibsLoaded);
      }
      
      private function addFileVersion(param1:String, param2:Boolean = true) : String
      {
         var version:String;
         var versionBase:String = null;
         var rootPath:String = null;
         var tempUrl:String = null;
         var index:int = 0;
         var xmlList:XMLList = null;
         var url:String = param1;
         var isFormat:Boolean = param2;
         if(url == null || url == "" || url.indexOf("fileVersion=") != -1)
         {
            return url;
         }
         version = "";
         if(verConf.xml)
         {
            rootPath = "res.17roco.qq.com/";
            tempUrl = url.toLocaleLowerCase();
            tempUrl = tempUrl.replace(/[\\\/]+/g,"/");
            versionBase = verConf.xml.@from;
            versionBase = versionBase.replace(/\D*/g,"");
            index = int(tempUrl.indexOf(rootPath));
            if(index != -1)
            {
               tempUrl = tempUrl.slice(index + rootPath.length);
            }
            index = int(tempUrl.indexOf("?"));
            if(index != -1)
            {
               tempUrl = tempUrl.slice(0,index);
            }
            xmlList = verConf.xml.file.(@path == tempUrl);
            if(xmlList.length() > 0)
            {
               version = xmlList[0].@version;
            }
         }
         if(isFormat)
         {
            url = url.replace(/[\\\/]+/g,"/");
            url = url.replace(":/r","://r");
            url = url.replace(":/R","://R");
            index = int(url.indexOf("?"));
            if(index != -1)
            {
               url = url.slice(0,index);
            }
         }
         if(IS_DEBUG)
         {
            version = Math.random().toString();
         }
         if(versionBase == null || versionBase == "")
         {
            versionBase = Math.random().toString();
         }
         url += url.indexOf("?") == -1 ? "?" : "&";
         url += "fileVersion=" + versionBase + (version == "" ? "" : "_" + version);
         return url;
      }
      
      protected function onConfLoadError(param1:ErrorEvent) : void
      {
         loadingUI.msg_txt.text = "错误:请刷新页面重试!";
         log(1,2);
      }
      
      private function loadVerConf() : void
      {
         verConf = new VerConfigLoader("//res.17roco.qq.com/ver.config?fileVersion=" + Math.random(),"",loadGlobalConf,verConfLoadError,2);
         verConf.load();
      }

      private function loadGlobalConf() : void
      {
         var _loc1_:String = null;
         globalConf = new GlobalConfig();
         globalConf.addEventListener(GlobalConfig.CONF_LOAD_OK,onConfLoadOk);
         if(stage.loaderInfo != null || stage.loaderInfo.parameters != null)
         {
            _loc1_ = stage.loaderInfo.parameters["config"];
         }
         if(_loc1_ == null)
         {
            _loc1_ = "//res.17roco.qq.com/Global.xml";
         }
         _loc1_ = _loc1_ + "?fileVersion=" + Math.random();
         globalConf.loadConf(_loc1_);
      }
      
      
      protected function verConfLoadError() : void
      {
         trace("版本号文件加载失败:请刷新页面重试!");
      }
      
      protected function onConfLoadOk(param1:Event) : void
      {
         var _loc5_:Object = null;
         IS_DEBUG = globalConf.IS_DEBUG;
         var _loc2_:QueueConfs = new QueueConfs();
         var _loc3_:Array = globalConf.Confs;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            _loc2_.addConf(_loc5_.name,addFileVersion(_loc5_.src),_loc5_.compress);
            _loc4_++;
         }
         _loc2_.start(onAllConfsLoaded,onConfsLoadError);
      }
      


      
      protected function onLibsLoaded() : void
      {
         log(getTimer() - timeline,3);
         var _loc1_:Class = getDefinitionByName("com.QQ.angel.api.net.DEFINE") as Class;
         _loc1_ && _loc1_["setVersionXML"](verConf.xml);
         if(_loc1_ == null || verConf.xml == null)
         {
            trace("版本号系统加载失败！");
         }
         angelMainApp = new (getDefinitionByName("com.QQ.angel.AngelMainApp") as Class)();
         var _loc2_:Function = SocketLogger.getInstance().log;
         var _loc3_:Function = SocketLogger.getInstance().logClient;
         angelMainApp.initialize(this,globalConf,libsLoader,_loc2_,_loc3_);
         bb.deactive();
         removeChild(loadingUI);
         loadingUI = null;
      }

      
   }
}

