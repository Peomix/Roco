package DataInfoCenterUtil.decoder
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class GIFDecoder
   {
      
      private static var STATUS_OK:int = 0;
      
      private static var STATUS_FORMAT_ERROR:int = 1;
      
      private static var STATUS_OPEN_ERROR:int = 2;
      
      private static var frameRect:Rectangle = new Rectangle();
      
      private static var MaxStackSize:int = 4096;
      
      private var inStream:ByteArray;
      
      private var status:int;
      
      private var width:int;
      
      private var height:int;
      
      private var gctFlag:Boolean;
      
      private var gctSize:int;
      
      private var loopCount:int = 1;
      
      private var gct:Array;
      
      private var lct:Array;
      
      private var act:Array;
      
      private var bgIndex:int;
      
      private var bgColor:int;
      
      private var lastBgColor:int;
      
      private var pixelAspect:int;
      
      private var lctFlag:Boolean;
      
      private var interlace:Boolean;
      
      private var lctSize:int;
      
      private var ix:int;
      
      private var iy:int;
      
      private var iw:int;
      
      private var ih:int;
      
      private var lastRect:Rectangle;
      
      private var image:BitmapData;
      
      private var bitmap:BitmapData;
      
      private var lastImage:BitmapData;
      
      private var block:ByteArray;
      
      private var blockSize:int = 0;
      
      private var dispose:int = 0;
      
      private var lastDispose:int = 0;
      
      private var transparency:Boolean = false;
      
      private var delay:int = 0;
      
      private var transIndex:int;
      
      private var prefix:Array;
      
      private var suffix:Array;
      
      private var pixelStack:Array;
      
      private var pixels:Array;
      
      private var frames:Array;
      
      private var frameCount:int;
      
      public function GIFDecoder()
      {
         super();
         this.block = new ByteArray();
      }
      
      public function get disposeValue() : int
      {
         return this.dispose;
      }
      
      public function getDelay(param1:int) : int
      {
         this.delay = -1;
         if(param1 >= 0 && param1 < this.frameCount)
         {
            this.delay = this.frames[param1].delay;
         }
         return this.delay;
      }
      
      public function getFrameCount() : int
      {
         return this.frameCount;
      }
      
      public function getImage() : GIFFrame
      {
         return this.getFrame(0);
      }
      
      public function getLoopCount() : int
      {
         return this.loopCount;
      }
      
      private function getPixels(param1:BitmapData) : Array
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Array = new Array(4 * this.image.width * this.image.height);
         var _loc3_:int = 0;
         var _loc4_:int = this.image.width;
         var _loc5_:int = this.image.height;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc4_)
            {
               _loc6_ = int(param1.getPixel(_loc7_,_loc8_));
               var _loc9_:*;
               _loc2_[_loc9_ = _loc3_++] = (_loc6_ & 0xFF0000) >> 16;
               var _loc10_:*;
               _loc2_[_loc10_ = _loc3_++] = (_loc6_ & 0xFF00) >> 8;
               var _loc11_:*;
               _loc2_[_loc11_ = _loc3_++] = _loc6_ & 0xFF;
               _loc8_++;
            }
            _loc7_++;
         }
         return _loc2_;
      }
      
      private function setPixels(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         param1.position = 0;
         var _loc4_:int = this.image.width;
         var _loc5_:int = this.image.height;
         this.bitmap.lock();
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc3_ = int(param1[int(_loc2_++)]);
               this.bitmap.setPixel32(_loc7_,_loc6_,_loc3_);
               _loc7_++;
            }
            _loc6_++;
         }
         this.bitmap.unlock();
      }
      
      private function transferPixels() : void
      {
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = 0;
         var _loc15_:int = 0;
         var _loc1_:Array = this.getPixels(this.bitmap);
         if(this.lastDispose > 0)
         {
            if(this.lastDispose == 3)
            {
               _loc6_ = this.frameCount - 2;
               this.lastImage = _loc6_ > 0 ? this.getFrame(_loc6_ - 1).bitmapData : null;
            }
            if(this.lastImage != null)
            {
               _loc7_ = this.getPixels(this.lastImage);
               _loc1_ = _loc7_.slice();
               if(this.lastDispose == 2)
               {
                  _loc8_ = this.transparency ? 0 : this.lastBgColor;
                  this.image.fillRect(this.lastRect,_loc8_);
               }
            }
         }
         var _loc2_:int = 1;
         var _loc3_:int = 8;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < this.ih)
         {
            _loc9_ = _loc5_;
            if(this.interlace)
            {
               if(_loc4_ >= this.ih)
               {
                  _loc2_++;
                  switch(_loc2_)
                  {
                     case 2:
                        _loc4_ = 4;
                        break;
                     case 3:
                        _loc4_ = 2;
                        _loc3_ = 4;
                        break;
                     case 4:
                        _loc4_ = 1;
                        _loc3_ = 2;
                  }
               }
               _loc9_ = _loc4_;
               _loc4_ += _loc3_;
            }
            _loc9_ += this.iy;
            if(_loc9_ < this.height)
            {
               _loc10_ = _loc9_ * this.width;
               _loc11_ = _loc10_ + this.ix;
               _loc12_ = _loc11_ + this.iw;
               if(_loc10_ + this.width < _loc12_)
               {
                  _loc12_ = _loc10_ + this.width;
               }
               _loc13_ = _loc5_ * this.iw;
               while(_loc11_ < _loc12_)
               {
                  _loc14_ = this.pixels[_loc13_++] & 0xFF;
                  _loc15_ = int(this.act[_loc14_]);
                  if(_loc15_ != 0)
                  {
                     _loc1_[_loc11_] = _loc15_;
                  }
                  _loc11_++;
               }
            }
            _loc5_++;
         }
         this.setPixels(_loc1_);
      }
      
      public function getFrame(param1:int) : GIFFrame
      {
         var _loc2_:GIFFrame = null;
         if(param1 >= 0 && param1 < this.frameCount)
         {
            return this.frames[param1];
         }
         throw new RangeError("Wrong frame number passed");
      }
      
      public function getFrameSize() : Rectangle
      {
         var _loc1_:Rectangle = GIFDecoder.frameRect;
         _loc1_.x = _loc1_.y = 0;
         _loc1_.width = this.width;
         _loc1_.height = this.height;
         return _loc1_;
      }
      
      public function read(param1:ByteArray) : int
      {
         this.init();
         if(param1 != null)
         {
            this.inStream = param1;
            this.readHeader();
            if(!this.hasError())
            {
               this.readContents();
               if(this.frameCount < 0)
               {
                  this.status = STATUS_FORMAT_ERROR;
               }
            }
         }
         else
         {
            this.status = STATUS_OPEN_ERROR;
         }
         return this.status;
      }
      
      private function decodeImageData() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = 0;
         var _loc15_:int = 0;
         var _loc16_:* = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc1_:int = -1;
         var _loc2_:int = this.iw * this.ih;
         if(this.pixels == null || this.pixels.length < _loc2_)
         {
            this.pixels = new Array(_loc2_);
         }
         if(this.prefix == null)
         {
            this.prefix = new Array(MaxStackSize);
         }
         if(this.suffix == null)
         {
            this.suffix = new Array(MaxStackSize);
         }
         if(this.pixelStack == null)
         {
            this.pixelStack = new Array(MaxStackSize + 1);
         }
         _loc15_ = this.readSingleByte();
         _loc4_ = 1 << _loc15_;
         _loc7_ = _loc4_ + 1;
         _loc3_ = _loc4_ + 2;
         _loc9_ = _loc1_;
         _loc6_ = _loc15_ + 1;
         _loc5_ = (1 << _loc6_) - 1;
         _loc11_ = 0;
         while(_loc11_ < _loc4_)
         {
            this.prefix[int(_loc11_)] = 0;
            this.suffix[int(_loc11_)] = _loc11_;
            _loc11_++;
         }
         _loc14_ = _loc10_ = _loc12_ = _loc16_ = _loc17_ = _loc19_ = _loc18_ = 0;
         _loc13_ = 0;
         while(_loc13_ < _loc2_)
         {
            if(_loc17_ == 0)
            {
               if(_loc10_ < _loc6_)
               {
                  if(_loc12_ == 0)
                  {
                     _loc12_ = this.readBlock();
                     if(_loc12_ <= 0)
                     {
                        break;
                     }
                     _loc18_ = 0;
                  }
                  _loc14_ += (int(this.block[int(_loc18_)]) & 0xFF) << _loc10_;
                  _loc10_ += 8;
                  _loc18_++;
                  _loc12_--;
                  continue;
               }
               _loc11_ = _loc14_ & _loc5_;
               _loc14_ >>= _loc6_;
               _loc10_ -= _loc6_;
               if(_loc11_ > _loc3_ || _loc11_ == _loc7_)
               {
                  break;
               }
               if(_loc11_ == _loc4_)
               {
                  _loc6_ = _loc15_ + 1;
                  _loc5_ = (1 << _loc6_) - 1;
                  _loc3_ = _loc4_ + 2;
                  _loc9_ = _loc1_;
                  continue;
               }
               if(_loc9_ == _loc1_)
               {
                  this.pixelStack[int(_loc17_++)] = this.suffix[int(_loc11_)];
                  _loc9_ = _loc11_;
                  _loc16_ = _loc11_;
                  continue;
               }
               _loc8_ = _loc11_;
               if(_loc11_ == _loc3_)
               {
                  this.pixelStack[int(_loc17_++)] = _loc16_;
                  _loc11_ = _loc9_;
               }
               while(_loc11_ > _loc4_)
               {
                  this.pixelStack[int(_loc17_++)] = this.suffix[int(_loc11_)];
                  _loc11_ = int(this.prefix[int(_loc11_)]);
               }
               _loc16_ = this.suffix[int(_loc11_)] & 0xFF;
               if(_loc3_ >= MaxStackSize)
               {
                  break;
               }
               this.pixelStack[int(_loc17_++)] = _loc16_;
               this.prefix[int(_loc3_)] = _loc9_;
               this.suffix[int(_loc3_)] = _loc16_;
               _loc3_++;
               if((_loc3_ & _loc5_) == 0 && _loc3_ < MaxStackSize)
               {
                  _loc6_++;
                  _loc5_ += _loc3_;
               }
               _loc9_ = _loc8_;
            }
            _loc17_--;
            this.pixels[int(_loc19_++)] = this.pixelStack[int(_loc17_)];
            _loc13_++;
         }
         _loc13_ = _loc19_;
         while(_loc13_ < _loc2_)
         {
            this.pixels[int(_loc13_)] = 0;
            _loc13_++;
         }
      }
      
      private function hasError() : Boolean
      {
         return this.status != STATUS_OK;
      }
      
      private function init() : void
      {
         this.status = STATUS_OK;
         this.frameCount = 0;
         this.frames = new Array();
         this.gct = null;
         this.lct = null;
      }
      
      private function readSingleByte() : int
      {
         var curByte:int = 0;
         try
         {
            curByte = int(this.inStream.readUnsignedByte());
         }
         catch(e:Error)
         {
            status = STATUS_FORMAT_ERROR;
         }
         return curByte;
      }
      
      private function readBlock() : int
      {
         var _loc2_:int = 0;
         this.blockSize = this.readSingleByte();
         var _loc1_:int = 0;
         if(this.blockSize > 0)
         {
            try
            {
               _loc2_ = 0;
               while(_loc1_ < this.blockSize)
               {
                  this.inStream.readBytes(this.block,_loc1_,this.blockSize - _loc1_);
                  if(this.blockSize - _loc1_ == -1)
                  {
                     break;
                  }
                  _loc1_ += this.blockSize - _loc1_;
               }
            }
            catch(e:Error)
            {
            }
            if(_loc1_ < this.blockSize)
            {
               this.status = STATUS_FORMAT_ERROR;
            }
         }
         return _loc1_;
      }
      
      private function readColorTable(param1:int) : Array
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc2_:int = 3 * param1;
         var _loc3_:Array = null;
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:int = 0;
         try
         {
            this.inStream.readBytes(_loc4_,0,_loc2_);
            _loc5_ = _loc2_;
         }
         catch(e:Error)
         {
         }
         if(_loc5_ < _loc2_)
         {
            this.status = STATUS_FORMAT_ERROR;
         }
         else
         {
            _loc3_ = new Array(256);
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc6_ < param1)
            {
               _loc8_ = _loc4_[_loc7_++] & 0xFF;
               _loc9_ = _loc4_[_loc7_++] & 0xFF;
               _loc10_ = _loc4_[_loc7_++] & 0xFF;
               var _loc11_:*;
               _loc3_[_loc11_ = _loc6_++] = 0xFF000000 | _loc8_ << 16 | _loc9_ << 8 | _loc10_;
            }
         }
         return _loc3_;
      }
      
      private function readContents() : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc1_:Boolean = false;
         while(!(_loc1_ || this.hasError()))
         {
            _loc2_ = this.readSingleByte();
            switch(_loc2_)
            {
               case 44:
                  this.readImage();
                  break;
               case 33:
                  _loc2_ = this.readSingleByte();
                  switch(_loc2_)
                  {
                     case 249:
                        this.readGraphicControlExt();
                        break;
                     case 255:
                        this.readBlock();
                        _loc3_ = "";
                        _loc4_ = 0;
                        while(_loc4_ < 11)
                        {
                           _loc3_ += this.block[int(_loc4_)];
                           _loc4_++;
                        }
                        if(_loc3_ == "NETSCAPE2.0")
                        {
                           this.readNetscapeExt();
                        }
                        else
                        {
                           this.skip();
                        }
                        break;
                     default:
                        this.skip();
                  }
                  break;
               case 59:
                  _loc1_ = true;
                  break;
               case 0:
                  break;
               default:
                  this.status = STATUS_FORMAT_ERROR;
                  break;
            }
         }
      }
      
      private function readGraphicControlExt() : void
      {
         this.readSingleByte();
         var _loc1_:int = this.readSingleByte();
         this.dispose = (_loc1_ & 0x1C) >> 2;
         if(this.dispose == 0)
         {
            this.dispose = 1;
         }
         this.transparency = (_loc1_ & 1) != 0;
         this.delay = this.readShort() * 10;
         this.transIndex = this.readSingleByte();
         this.readSingleByte();
      }
      
      private function readHeader() : void
      {
         var _loc1_:String = "";
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc1_ += String.fromCharCode(this.readSingleByte());
            _loc2_++;
         }
         if(_loc1_.indexOf("GIF") != 0)
         {
            this.status = STATUS_FORMAT_ERROR;
            throw new Error("Invalid file type");
         }
         this.readLSD();
         if(this.gctFlag && !this.hasError())
         {
            this.gct = this.readColorTable(this.gctSize);
            this.bgColor = this.gct[this.bgIndex];
         }
      }
      
      private function readImage() : void
      {
         this.ix = this.readShort();
         this.iy = this.readShort();
         this.iw = this.readShort();
         this.ih = this.readShort();
         var _loc1_:int = this.readSingleByte();
         this.lctFlag = (_loc1_ & 0x80) != 0;
         this.interlace = (_loc1_ & 0x40) != 0;
         this.lctSize = 2 << (_loc1_ & 7);
         if(this.lctFlag)
         {
            this.lct = this.readColorTable(this.lctSize);
            this.act = this.lct;
         }
         else
         {
            this.act = this.gct;
            if(this.bgIndex == this.transIndex)
            {
               this.bgColor = 0;
            }
         }
         var _loc2_:int = 0;
         if(this.transparency)
         {
            _loc2_ = int(this.act[this.transIndex]);
            this.act[this.transIndex] = 0;
         }
         if(this.act == null)
         {
            this.status = STATUS_FORMAT_ERROR;
         }
         if(this.hasError())
         {
            return;
         }
         this.decodeImageData();
         this.skip();
         if(this.hasError())
         {
            return;
         }
         ++this.frameCount;
         this.bitmap = new BitmapData(this.width,this.height);
         this.image = this.bitmap;
         this.transferPixels();
         this.frames.push(new GIFFrame(this.bitmap,this.delay));
         if(this.transparency)
         {
            this.act[this.transIndex] = _loc2_;
         }
         this.resetFrame();
      }
      
      private function readLSD() : void
      {
         this.width = this.readShort();
         this.height = this.readShort();
         var _loc1_:int = this.readSingleByte();
         this.gctFlag = (_loc1_ & 0x80) != 0;
         this.gctSize = 2 << (_loc1_ & 7);
         this.bgIndex = this.readSingleByte();
         this.pixelAspect = this.readSingleByte();
      }
      
      private function readNetscapeExt() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         do
         {
            this.readBlock();
            if(this.block[0] == 1)
            {
               _loc1_ = this.block[1] & 0xFF;
               _loc2_ = this.block[2] & 0xFF;
               this.loopCount = _loc2_ << 8 | _loc1_;
            }
         }
         while(this.blockSize > 0 && !this.hasError());
         
      }
      
      private function readShort() : int
      {
         return this.readSingleByte() | this.readSingleByte() << 8;
      }
      
      private function resetFrame() : void
      {
         this.lastDispose = this.dispose;
         this.lastRect = new Rectangle(this.ix,this.iy,this.iw,this.ih);
         this.lastImage = this.image;
         this.lastBgColor = this.bgColor;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         this.lct = null;
      }
      
      private function skip() : void
      {
         do
         {
            this.readBlock();
         }
         while(this.blockSize > 0 && !this.hasError());
         
      }
   }
}

