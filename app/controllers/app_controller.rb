class AppController < ApplicationController
  # encoding: utf-8
  def control; end

  def decryptControl; end

  def encrypt
    encryptedMsg = ""
    if params[:msg].length > 0
      msg = params[:msg]
      @msg = msg.split(' ')
      salt = rand(97..122)
      puts salt
      @msg.each do |w|
        ws = w.split('')
        for l in ws
          encryptedMsg += "#{(l.ord * salt).to_s}_"
        end
        encryptedMsg += "-"
      end
      encryptedMsg += (salt * (@msg.length + 120)).to_s
    else
      encryptedMsg = "empty string"
    end
    redirect_to root_path, notice: encryptedMsg
  end

  def decrypt
    decryptMsg = ""
    if params[:msg].length > 0
      msg = params[:msg]
      @msg = msg.split('-')
      salt = @msg[@msg.length - 1].to_i / (@msg.length + 120)
      @msg.delete_at(@msg.length-1)
      @msg.each do |w|
        ws = w.split('_')
        for l in ws
          decryptMsg += (l.to_i / salt).chr
        end
        decryptMsg += " "
      end
    else
      decryptMsg = "empty string"
    end
    redirect_to '/decrypt', notice: decryptMsg
  end
end