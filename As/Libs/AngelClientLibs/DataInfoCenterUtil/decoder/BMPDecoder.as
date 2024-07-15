package DataInfoCenterUtil.decoder
{
   import flash.display.BitmapData;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class BMPDecoder
   {
       
      
      private const BITMAP_HEADER_TYPE:String = "BM";
      
      private const BITMAP_FILE_HEADER_SIZE:int = 14;
      
      private const BITMAP_CORE_HEADER_SIZE:int = 12;
      
      private const BITMAP_INFO_HEADER_SIZE:int = 40;
      
      private const COMP_RGB:int = 0;
      
      private const COMP_RLE8:int = 1;
      
      private const COMP_RLE4:int = 2;
      
      private const COMP_BITFIELDS:int = 3;
      
      private const BIT1:int = 1;
      
      private const BIT4:int = 4;
      
      private const BIT8:int = 8;
      
      private const BIT16:int = 16;
      
      private const BIT24:int = 24;
      
      private const BIT32:int = 32;
      
      private var bytes:ByteArray;
      
      private var palette:Array;
      
      private var bd:BitmapData;
      
      private var nFileSize:uint;
      
      private var nReserved1:uint;
      
      private var nReserved2:uint;
      
      private var nOffbits:uint;
      
      private var nInfoSize:uint;
      
      private var nWidth:int;
      
      private var nHeight:int;
      
      private var nPlains:uint;
      
      private var nBitsPerPixel:uint;
      
      private var nCompression:uint;
      
      private var nSizeImage:uint;
      
      private var nXPixPerMeter:int;
      
      private var nYPixPerMeter:int;
      
      private var nColorUsed:uint;
      
      private var nColorImportant:uint;
      
      private var nRMask:uint;
      
      private var nGMask:uint;
      
      private var nBMask:uint;
      
      private var nRPos:uint;
      
      private var nGPos:uint;
      
      private var nBPos:uint;
      
      private var nRMax:uint;
      
      private var nGMax:uint;
      
      private var nBMax:uint;
      
      public function BMPDecoder()
      {
         super();
         this.nRPos = 0;
         this.nGPos = 0;
         this.nBPos = 0;
      }
      
      public function decode(param1:ByteArray) : BitmapData
      {
         this.bytes = param1;
         this.bytes.endian = Endian.LITTLE_ENDIAN;
         this.bytes.position = 0;
         this.readFileHeader();
         this.nInfoSize = this.bytes.readUnsignedInt();
         switch(this.nInfoSize)
         {
            case this.BITMAP_CORE_HEADER_SIZE:
               this.readCoreHeader();
               break;
            case this.BITMAP_INFO_HEADER_SIZE:
               this.readInfoHeader();
               break;
            default:
               this.readExtendedInfoHeader();
         }
         this.bd = new BitmapData(this.nWidth,this.nHeight);
         switch(this.nBitsPerPixel)
         {
            case this.BIT1:
               this.readColorPalette();
               this.decode1BitBMP();
               break;
            case this.BIT4:
               this.readColorPalette();
               if(this.nCompression == this.COMP_RLE4)
               {
                  this.decode4bitRLE();
               }
               else
               {
                  this.decode4BitBMP();
               }
               break;
            case this.BIT8:
               this.readColorPalette();
               if(this.nCompression == this.COMP_RLE8)
               {
                  this.decode8BitRLE();
               }
               else
               {
                  this.decode8BitBMP();
               }
               break;
            case this.BIT16:
               this.readBitFields();
               this.checkColorMask();
               this.decode16BitBMP();
               break;
            case this.BIT24:
               this.decode24BitBMP();
               break;
            case this.BIT32:
               this.readBitFields();
               this.checkColorMask();
               this.decode32BitBMP();
               break;
            default:
               throw new VerifyError("invalid bits per pixel : " + this.nBitsPerPixel);
         }
         return this.bd;
      }
      
      private function readFileHeader() : void
      {
         var fileHeader:ByteArray = new ByteArray();
         fileHeader.endian = Endian.LITTLE_ENDIAN;
         try
         {
            this.bytes.readBytes(fileHeader,0,this.BITMAP_FILE_HEADER_SIZE);
            if(fileHeader.readUTFBytes(2) != this.BITMAP_HEADER_TYPE)
            {
               throw new VerifyError("invalid bitmap header type");
            }
            this.nFileSize = fileHeader.readUnsignedInt();
            this.nReserved1 = fileHeader.readUnsignedShort();
            this.nReserved2 = fileHeader.readUnsignedShort();
            this.nOffbits = fileHeader.readUnsignedInt();
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid file header");
         }
      }
      
      private function readCoreHeader() : void
      {
         var coreHeader:ByteArray = new ByteArray();
         coreHeader.endian = Endian.LITTLE_ENDIAN;
         try
         {
            this.bytes.readBytes(coreHeader,0,this.BITMAP_CORE_HEADER_SIZE - 4);
            this.nWidth = coreHeader.readShort();
            this.nHeight = coreHeader.readShort();
            this.nPlains = coreHeader.readUnsignedShort();
            this.nBitsPerPixel = coreHeader.readUnsignedShort();
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid core header");
         }
      }
      
      private function readInfoHeader() : void
      {
         var infoHeader:ByteArray = new ByteArray();
         infoHeader.endian = Endian.LITTLE_ENDIAN;
         try
         {
            this.bytes.readBytes(infoHeader,0,this.BITMAP_INFO_HEADER_SIZE - 4);
            this.nWidth = infoHeader.readInt();
            this.nHeight = infoHeader.readInt();
            this.nPlains = infoHeader.readUnsignedShort();
            this.nBitsPerPixel = infoHeader.readUnsignedShort();
            this.nCompression = infoHeader.readUnsignedInt();
            this.nSizeImage = infoHeader.readUnsignedInt();
            this.nXPixPerMeter = infoHeader.readInt();
            this.nYPixPerMeter = infoHeader.readInt();
            this.nColorUsed = infoHeader.readUnsignedInt();
            this.nColorImportant = infoHeader.readUnsignedInt();
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid info header");
         }
      }
      
      private function readExtendedInfoHeader() : void
      {
         var infoHeader:ByteArray = new ByteArray();
         infoHeader.endian = Endian.LITTLE_ENDIAN;
         try
         {
            this.bytes.readBytes(infoHeader,0,this.nInfoSize - 4);
            this.nWidth = infoHeader.readInt();
            this.nHeight = infoHeader.readInt();
            this.nPlains = infoHeader.readUnsignedShort();
            this.nBitsPerPixel = infoHeader.readUnsignedShort();
            this.nCompression = infoHeader.readUnsignedInt();
            this.nSizeImage = infoHeader.readUnsignedInt();
            this.nXPixPerMeter = infoHeader.readInt();
            this.nYPixPerMeter = infoHeader.readInt();
            this.nColorUsed = infoHeader.readUnsignedInt();
            this.nColorImportant = infoHeader.readUnsignedInt();
            if(infoHeader.bytesAvailable >= 4)
            {
               this.nRMask = infoHeader.readUnsignedInt();
            }
            if(infoHeader.bytesAvailable >= 4)
            {
               this.nGMask = infoHeader.readUnsignedInt();
            }
            if(infoHeader.bytesAvailable >= 4)
            {
               this.nBMask = infoHeader.readUnsignedInt();
            }
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid info header");
         }
      }
      
      private function readBitFields() : void
      {
         if(this.nCompression == this.COMP_RGB)
         {
            if(this.nBitsPerPixel == this.BIT16)
            {
               this.nRMask = 31744;
               this.nGMask = 992;
               this.nBMask = 31;
            }
            else
            {
               this.nRMask = 16711680;
               this.nGMask = 65280;
               this.nBMask = 255;
            }
         }
         else if(this.nCompression == this.COMP_BITFIELDS && this.nInfoSize < 52)
         {
            try
            {
               this.nRMask = this.bytes.readUnsignedInt();
               this.nGMask = this.bytes.readUnsignedInt();
               this.nBMask = this.bytes.readUnsignedInt();
            }
            catch(e:IOError)
            {
               throw new VerifyError("invalid bit fields");
            }
         }
      }
      
      private function readColorPalette() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = this.nColorUsed > 0 ? int(this.nColorUsed) : int(Math.pow(2,this.nBitsPerPixel));
         this.palette = new Array(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.palette[_loc1_] = this.bytes.readUnsignedInt();
            _loc1_++;
         }
      }
      
      private function decode1BitBMP() : void
      {
         var x:int = 0;
         var y:int = 0;
         var i:int = 0;
         var col:int = 0;
         var buf:ByteArray = new ByteArray();
         var line:int = this.nWidth / 8;
         if(line % 4 > 0)
         {
            line = ((line / 4 | 0) + 1) * 4;
         }
         try
         {
            y = this.nHeight - 1;
            while(y >= 0)
            {
               buf.length = 0;
               this.bytes.readBytes(buf,0,line);
               x = 0;
               while(x < this.nWidth)
               {
                  col = int(buf.readUnsignedByte());
                  i = 0;
                  while(i < 8)
                  {
                     this.bd.setPixel(x + i,y,this.palette[col >> 7 - i & 1]);
                     i++;
                  }
                  x += 8;
               }
               y--;
            }
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid image data");
         }
      }
      
      private function decode4bitRLE() : void
      {
         var x:int = 0;
         var y:int = 0;
         var i:int = 0;
         var n:int = 0;
         var col:int = 0;
         var data:uint = 0;
         var buf:ByteArray = new ByteArray();
         try
         {
            y = this.nHeight - 1;
            while(y >= 0)
            {
               buf.length = 0;
               while(this.bytes.bytesAvailable > 0)
               {
                  n = int(this.bytes.readUnsignedByte());
                  if(n > 0)
                  {
                     data = this.bytes.readUnsignedByte();
                     i = 0;
                     while(i < n / 2)
                     {
                        buf.writeByte(data);
                        i++;
                     }
                  }
                  else
                  {
                     n = int(this.bytes.readUnsignedByte());
                     if(n <= 0)
                     {
                        break;
                     }
                     this.bytes.readBytes(buf,buf.length,n / 2);
                     buf.position += n / 2;
                     if(n / 2 + 1 >> 1 << 1 != n / 2)
                     {
                        this.bytes.readUnsignedByte();
                     }
                  }
               }
               buf.position = 0;
               x = 0;
               while(x < this.nWidth)
               {
                  col = int(buf.readUnsignedByte());
                  this.bd.setPixel(x,y,this.palette[col >> 4]);
                  this.bd.setPixel(x + 1,y,this.palette[col & 15]);
                  x += 2;
               }
               y--;
            }
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid image data");
         }
      }
      
      private function decode4BitBMP() : void
      {
         var x:int = 0;
         var y:int = 0;
         var i:int = 0;
         var col:int = 0;
         var buf:ByteArray = new ByteArray();
         var line:int = this.nWidth / 2;
         if(line % 4 > 0)
         {
            line = ((line / 4 | 0) + 1) * 4;
         }
         try
         {
            y = this.nHeight - 1;
            while(y >= 0)
            {
               buf.length = 0;
               this.bytes.readBytes(buf,0,line);
               x = 0;
               while(x < this.nWidth)
               {
                  col = int(buf.readUnsignedByte());
                  this.bd.setPixel(x,y,this.palette[col >> 4]);
                  this.bd.setPixel(x + 1,y,this.palette[col & 15]);
                  x += 2;
               }
               y--;
            }
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid image data");
         }
      }
      
      private function decode8BitRLE() : void
      {
         var x:int = 0;
         var y:int = 0;
         var i:int = 0;
         var n:int = 0;
         var col:int = 0;
         var data:uint = 0;
         var buf:ByteArray = new ByteArray();
         try
         {
            y = this.nHeight - 1;
            while(y >= 0)
            {
               buf.length = 0;
               while(this.bytes.bytesAvailable > 0)
               {
                  n = int(this.bytes.readUnsignedByte());
                  if(n > 0)
                  {
                     data = this.bytes.readUnsignedByte();
                     i = 0;
                     while(i < n)
                     {
                        buf.writeByte(data);
                        i++;
                     }
                  }
                  else
                  {
                     n = int(this.bytes.readUnsignedByte());
                     if(n <= 0)
                     {
                        break;
                     }
                     this.bytes.readBytes(buf,buf.length,n);
                     buf.position += n;
                     if(n + 1 >> 1 << 1 != n)
                     {
                        this.bytes.readUnsignedByte();
                     }
                  }
               }
               buf.position = 0;
               if(buf.length < this.nWidth)
               {
                  buf.length = this.nWidth;
               }
               x = 0;
               while(x < this.nWidth)
               {
                  this.bd.setPixel(x,y,this.palette[buf.readUnsignedByte()]);
                  x++;
               }
               y--;
            }
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid image data");
         }
      }
      
      private function decode8BitBMP() : void
      {
         var x:int = 0;
         var y:int = 0;
         var i:int = 0;
         var col:int = 0;
         var buf:ByteArray = new ByteArray();
         var line:int = this.nWidth;
         if(line % 4 > 0)
         {
            line = ((line / 4 | 0) + 1) * 4;
         }
         try
         {
            y = this.nHeight - 1;
            while(y >= 0)
            {
               buf.length = 0;
               this.bytes.readBytes(buf,0,line);
               x = 0;
               while(x < this.nWidth)
               {
                  this.bd.setPixel(x,y,this.palette[buf.readUnsignedByte()]);
                  x++;
               }
               y--;
            }
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid image data");
         }
      }
      
      private function decode16BitBMP() : void
      {
         var x:int = 0;
         var y:int = 0;
         var col:int = 0;
         try
         {
            y = this.nHeight - 1;
            while(y >= 0)
            {
               x = 0;
               while(x < this.nWidth)
               {
                  col = int(this.bytes.readUnsignedShort());
                  this.bd.setPixel(x,y,(((col & this.nRMask) >> this.nRPos) * 255 / this.nRMax << 16) + (((col & this.nGMask) >> this.nGPos) * 255 / this.nGMax << 8) + (((col & this.nBMask) >> this.nBPos) * 255 / this.nBMax << 0));
                  x++;
               }
               y--;
            }
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid image data");
         }
      }
      
      private function decode24BitBMP() : void
      {
         var x:int = 0;
         var y:int = 0;
         var col:int = 0;
         var buf:ByteArray = new ByteArray();
         var line:int = this.nWidth * 3;
         if(line % 4 > 0)
         {
            line = ((line / 4 | 0) + 1) * 4;
         }
         try
         {
            y = this.nHeight - 1;
            while(y >= 0)
            {
               buf.length = 0;
               this.bytes.readBytes(buf,0,line);
               x = 0;
               while(x < this.nWidth)
               {
                  this.bd.setPixel(x,y,buf.readUnsignedByte() + (buf.readUnsignedByte() << 8) + (buf.readUnsignedByte() << 16));
                  x++;
               }
               y--;
            }
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid image data");
         }
      }
      
      private function decode32BitBMP() : void
      {
         var x:int = 0;
         var y:int = 0;
         var col:int = 0;
         try
         {
            y = this.nHeight - 1;
            while(y >= 0)
            {
               x = 0;
               while(x < this.nWidth)
               {
                  col = int(this.bytes.readUnsignedInt());
                  this.bd.setPixel(x,y,(((col & this.nRMask) >> this.nRPos) * 255 / this.nRMax << 16) + (((col & this.nGMask) >> this.nGPos) * 255 / this.nGMax << 8) + (((col & this.nBMask) >> this.nBPos) * 255 / this.nBMax << 0));
                  x++;
               }
               y--;
            }
         }
         catch(e:IOError)
         {
            throw new VerifyError("invalid image data");
         }
      }
      
      private function checkColorMask() : void
      {
         if(this.nRMask & this.nGMask | this.nGMask & this.nBMask | this.nBMask & this.nRMask)
         {
            throw new VerifyError("invalid bit fields");
         }
         while(this.nRMask >> this.nRPos & 1 == 0)
         {
            ++this.nRPos;
         }
         while(this.nGMask >> this.nGPos & 1 == 0)
         {
            ++this.nGPos;
         }
         while(this.nBMask >> this.nBPos & 1 == 0)
         {
            ++this.nBPos;
         }
         this.nRMax = this.nRMask >> this.nRPos;
         this.nGMax = this.nGMask >> this.nGPos;
         this.nBMax = this.nBMask >> this.nBPos;
      }
      
      public function traceInfo() : void
      {
         trace("---- FILE HEADER ----");
         trace("nFileSize: " + this.nFileSize);
         trace("nReserved1: " + this.nReserved1);
         trace("nReserved2: " + this.nReserved2);
         trace("nOffbits: " + this.nOffbits);
         trace("---- INFO HEADER ----");
         trace("nWidth: " + this.nWidth);
         trace("nHeight: " + this.nHeight);
         trace("nPlains: " + this.nPlains);
         trace("nBitsPerPixel: " + this.nBitsPerPixel);
         if(this.nInfoSize >= 40)
         {
            trace("nCompression: " + this.nCompression);
            trace("nSizeImage: " + this.nSizeImage);
            trace("nXPixPerMeter: " + this.nXPixPerMeter);
            trace("nYPixPerMeter: " + this.nYPixPerMeter);
            trace("nColorUsed: " + this.nColorUsed);
            trace("nColorUsed: " + this.nColorImportant);
         }
         if(this.nInfoSize >= 52)
         {
            trace("nRMask: " + this.nRMask.toString(2));
            trace("nGMask: " + this.nGMask.toString(2));
            trace("nBMask: " + this.nBMask.toString(2));
         }
      }
   }
}
