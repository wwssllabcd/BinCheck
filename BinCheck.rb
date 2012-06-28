# encoding: utf-8

require 'dl'
class WinUtility
  # button constants
  BUTTONS_OK = 0
  BUTTONS_OKCANCEL = 1
  BUTTONS_ABORTRETRYIGNORE = 2
  BUTTONS_YESNO = 4

  # return code constants
  CLICKED_OK = 1
  CLICKED_CANCEL = 2
  CLICKED_ABORT = 3
  CLICKED_RETRY = 4
  CLICKED_IGNORE = 5
  CLICKED_YES = 6
  CLICKED_NO = 7
  def message_box(txt, title="APP_TITLE", buttons=BUTTONS_OK)
    user32 = DL.dlopen('user32')
    
    #msgbox = user32['MessageBoxA', 'ILSSI']
    #r, rs = msgbox.call(0, txt, title, buttons)
    
    msgbox = DL::CFunc.new(user32['MessageBoxA'], DL::TYPE_LONG, 'MessageBox')
    r, rs = msgbox.call([0, txt, title, 0].pack('L!ppL!').unpack('L!*'))
      
    return r
  end
end

#=======================================
class Utility
  def crlf()
    return "\n"
  end
end

#=======================================
def compareBin(fName1, fName2, startAddr, endAddr)

  if( FileTest::exist?(fName1) == false )
    puts "file does not exist"
    return
  end

  io = File.open(fName1, "rb")
  data_1 = io.read()
  io.close
  if checkInput(data_1, startAddr, endAddr, fName1) == false
    return
  end

  data_2 = File.open(fName2, "rb").read()
  if checkInput(data_2, startAddr, endAddr, fName2) == false
    return
  end

  wu = WinUtility.new
  for i in startAddr ... endAddr
    if data_1[i] != data_2[i] then
      msg = "Find Diff in 0x%X", i
      message_box(msg)
    end
  end
end

def checkInput(data, startAddr, endAddr, name)
  if data.size() < startAddr
    puts "startAddr out of boundary" + name
    return false
  end
  if data.size() < endAddr
    puts "endAddr out of boundary" + name
    return false
  end
  return true
end

def showHelp()
  u = Utility.new()
  msg = ""
  msg += "1. 檢查兩個檔案是否相同" + u.crlf();
  msg += "   ex:BinCheck.exe /c 2090-RAM.BIN 2090_16K.bin 2048 16383" + u.crlf()
  msg += "   代表檢查2090-RAM.BIN與2090_16K.bin這兩個檔案的 2048~16383是否相同" + u.crlf()
  msg +=  u.crlf()
  msg += "2. 檢查某個檔案中的某串byte 是某種pattern" + u.crlf()
  msg += "   ex:BinCheck.exe /x 2090-ROM.BIN 0x7f8 8 0" + u.crlf()
  msg += "   檢查2090-ROM.BIN 的0x7f8，往後的8個byte是否為0" + u.crlf()

  # for console mode of window
  #puts msg.encode("Big5")
  puts msg
  puts msg.encode

end

def checkBinPattern(fName, startAddr, len, pattern)

  io = File.open(fName, "rb")
  io.pos = startAddr

  wu = WinUtility.new()
  len.times{|i|
    # for Ruby 193
    tmp = io.getc().hex  
    if tmp!=pattern
      msg = "Find Diff in 0x" + (startAddr + i).to_s(16)
      wu.message_box(msg)
      break;
    end
  }
  io.close
end

#================= main ==========

op = ARGV[0]
arg1 = ARGV[1]
arg2 = ARGV[2]
arg3 = ARGV[3]
arg4 = ARGV[4]

case op
when "/?"
  showHelp()
when "/c"
  compareBin( arg1, arg2, arg3.to_i(), arg4.to_i() )
when "/x"
  checkBinPattern( arg1, arg2.hex, arg3.to_i(), arg4.to_i() )
else
  puts "can't parser op"
end

#message_box("down", "Hi!", BUTTONS_OK)
