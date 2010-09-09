/*_____ __  __ _______ _____  __  __       _ _           
 / ____|  \/  |__   __|  __ \|  \/  |     (_) |          
| (___ | \  / |  | |  | |__) | \  / | __ _ _| | ___ _ __ 
 \___ \| |\/| |  | |  |  ___/| |\/| |/ _` | | |/ _ \ '__|
 ____) | |  | |  | |  | |    | |  | | (_| | | |  __/ |   
|_____/|_|  |_|  |_|  |_|    |_|  |_|\__,_|_|_|\___|_|                                                    
/*
* This class lets you send rich emails with AS3 (html, attached files) through SMTP
* for more infos http://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol
* @author Thibault Imbert (bytearray.org)
* @version 0.3 Added image type auto detect (PNG, JPG-JPEG)
* @version 0.4 Dispatching proper events
* @version 0.5 Handles every kind of files for attachment, few bugs fixed
* @version 0.6 Handles authentication, thank you Wein ;)
* @version 0.7 Few fixes, thank you Vicente ;)
* @version 0.8 Good fix, thank you Ben and Carlos ;)
*/
package org.smtp.mailer
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import org.smtp.crypto.MD5;
	import org.smtp.encoding.Base64;
	import org.smtp.events.SMTPEvent;
	
	public class SMTPMailer extends Socket 
	{
		private var m_user:String;
		private var m_pass:String;
		private var m_host:String;
		private var m_message:String;
		private var m_from:String;
		private var m_dest:String;
		private var m_subject:String;
		
		// PNG, JPEG header values
		private static const PNG:Number = 0x89504E47;
		private static const JPEG:Number = 0xFFD8;
		
		// common SMTP server response codes
		// other codes could be added to add fonctionalities and more events
		private static const ACTION_OK:Number = 0xFA;
		private static const AUTH_CHALLENGE:Number = 0x14E;
		private static const AUTHENTICATED:Number = 0xEB;
		private static const DISCONNECTED:Number = 0xDD;
		private static const READY:Number = 0xDC;
		private static const DATA:Number = 0x162;
		private static const BAD_SEQUENCE:Number = 0x1F7;
		
		public function SMTPMailer (sHost:String) : void
		{
			super ();
			
			m_host = sHost;
			addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			addEventListener(SMTPEvent.DATA, sendData);
			addEventListener(SMTPEvent.AUTH_USER, onAuthUser);
			addEventListener(SMTPEvent.AUTH_PASS, onAuthPass);
			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR , ioErrorHandler);
		}
		
		/*
		* This method lets you authenticate, just pass a login and password
		*/
		public function authenticate ( pLogin:String, pPass:String ):void
		{
			m_user = pLogin;
			m_pass = pPass;
			writeUTFBytes ("EHLO "+m_host+"\r\n");
			writeUTFBytes ("AUTH LOGIN\r\n");
			flush();
		}
		
		
		private function onAuthPass(result:Object) : void
		{
			writeUTFBytes (Base64.encode64String (m_pass)+"\r\n");
			flush();
		}
		
		private function onAuthUser(result:Object) : void
		{
			writeUTFBytes (Base64.encode64String (m_user)+"\r\n");
			flush();
		}
		
		public override function connect(host:String, port:int) : void
		{
			super.connect(host,port);
			
			this.writeUTFBytes ("EHLO "+m_host+"\r\n");
			this.flush();
		}
		
		/*
		* This method is used to send emails with attached files and HTML 
		* takes an incoming Bytearray and convert it to base64 string
		* for instance pass a JPEG ByteArray stream to get a picture attached in the mail ;)
		*/
		public function sendAttachedMail ( pFrom:String, pDest:String, pSubject:String, pMess:String, pByteArray:ByteArray, pFileName:String ) :void
		{
			try {
				writeUTFBytes ("HELO "+m_host+"\r\n");
				writeUTFBytes ("MAIL FROM: <"+pFrom+">\r\n");
				writeUTFBytes ("RCPT TO: <"+pDest+">\r\n");
				writeUTFBytes ("DATA\r\n");
				writeUTFBytes ("From: "+pFrom+"\r\n");
				writeUTFBytes ("To: "+pDest+"\r\n");
				writeUTFBytes ("Date : "+new Date().toString()+"\r\n");
				writeUTFBytes ("Subject: "+pSubject+"\r\n");
				writeUTFBytes ("Mime-Version: 1.0\r\n");
				
				var md5Boundary:String = MD5.hash ( String ( getTimer() ) );
				
				writeUTFBytes ("Content-Type: multipart/mixed; boundary=------------"+md5Boundary+"\r\n");
				writeUTFBytes("\r\n");
				writeUTFBytes ("This is a multi-part message in MIME format.\r\n");
				writeUTFBytes ("--------------"+md5Boundary+"\r\n");
				writeUTFBytes ("Content-Type: text/html; charset=UTF-8; format=flowed\r\n");
				writeUTFBytes("\r\n");
				writeUTFBytes (pMess+"\r\n");
				writeUTFBytes ("--------------"+md5Boundary+"\r\n");
				writeUTFBytes ( readHeader (pByteArray, pFileName) );
				writeUTFBytes ("Content-Transfer-Encoding: base64\r\n");
				writeUTFBytes ("\r\n");

				var base64String:String = Base64.encode64 ( pByteArray, true );
				writeUTFBytes ( base64String+"\r\n");
				writeUTFBytes ("--------------"+md5Boundary+"-\r\n");
				writeUTFBytes (".\r\n");
				flush();
			}
			catch ( pError:Error )
			{
				trace("Error : Socket error, please check the sendAttachedMail() method parameters");
				trace("Arguments : " + arguments );
			}
		}
		
		/*
		* This method is used to send HTML emails
		* just pass the HTML string to pMess
		*/
		public function sendHTMLMail ( pFrom:String, pDest:String, pSubject:String, pMess:String ):void
		{
			m_message = pMess;
			m_from = pFrom;
			m_dest = pDest;
			m_subject = pSubject;
			
			try 
			{
				writeUTFBytes ("HELO "+m_host+"\r\n");
				writeUTFBytes ("MAIL FROM: <"+pFrom+">\r\n");
				writeUTFBytes ("RCPT TO: <"+pDest+">\r\n");
				writeUTFBytes ("DATA\r\n");				
				flush();
			}
			catch ( pError:Error )
			{
				trace("Error : Socket error, please check the sendHTMLMail() method parameters");
				trace("Arguments : " + arguments );
			}
		}
		
		private function sendData(response:Object) : void
		{
				writeUTFBytes ("From: "+m_from+"\r\n");
				writeUTFBytes ("To: "+m_dest+"\r\n");
				writeUTFBytes ("Subject: "+m_subject+"\r\n");
				writeUTFBytes ("Mime-Version: 1.0\r\n");
				writeUTFBytes ("Content-Type: text/html; charset=UTF-8; format=flowed\r\n");
				writeUTFBytes("\r\n");
				writeUTFBytes (m_message+"\r\n");
				writeUTFBytes (".\r\n");
				flush();
		}
		
		/*
		* This method automatically detects the header of the binary stream and returns appropriate headers (jpg, png)
		* classic application/octet-stream content type is added for different kind of files
		*/
		private function readHeader ( pByteArray:ByteArray, pFileName:String ):String 
		{
			pByteArray.position = 0;
			
			var sOutput:String = null;
			
			if ( pByteArray.readUnsignedInt () == SMTPMailer.PNG ) 
			{
				sOutput = "Content-Type: image/png; name="+pFileName+"\r\n";
				sOutput += "Content-Disposition: attachment filename="+pFileName+"\r\n";
				return sOutput;
			}
			
			pByteArray.position = 0;

			if ( pByteArray.readUnsignedShort() == SMTPMailer.JPEG ) 
			{
				sOutput = "Content-Type: image/jpeg; name="+pFileName+"\r\n";
				sOutput += "Content-Disposition: attachment filename="+pFileName+"\r\n";
				return sOutput;
			}
				
			sOutput = "Content-Type: application/octet-stream; name="+pFileName+"\r\n";
			sOutput += "Content-Disposition: attachment filename="+pFileName+"\r\n";
			return sOutput;
		}
		
		// check SMTP response and dispatch proper events
		private function socketDataHandler ( pEvt:ProgressEvent ):void
		{
			var response:String = pEvt.target.readUTFBytes ( pEvt.target.bytesAvailable );
			var reg:RegExp = /^\d{3}/img;
			var buffer:Array = new Array();
			var result:Object = reg.exec(response);

			while (result != null) 
			{
				buffer.push (result[0]);
				result = reg.exec(response);
			}
			
			var smtpReturn:Number = buffer[buffer.length-1];
			var smtpInfos:Object = { code : smtpReturn, message : response };
			
			if (smtpReturn == SMTPMailer.READY) dispatchEvent(new SMTPEvent(SMTPEvent.CONNECTED, smtpInfos));
			
			else if ( smtpReturn == SMTPMailer.ACTION_OK && (response.toLowerCase().indexOf ("queued") != -1 || response.toLowerCase().indexOf ("accepted") != -1 || response.toLowerCase().indexOf ("qp") != -1) ) dispatchEvent ( new SMTPEvent ( SMTPEvent.MAIL_SENT, smtpInfos ) );
			
			else if (smtpReturn == SMTPMailer.ACTION_OK) dispatchEvent(new SMTPEvent(SMTPEvent.ACTION_OK, smtpInfos));
			
			// 334 + first three chars of 'VXN' which is part of the word 'user' base64 encoded
			else if (smtpReturn == SMTPMailer.AUTH_CHALLENGE && (response.toLocaleLowerCase().indexOf("vxn") != -1)) dispatchEvent(new SMTPEvent(SMTPEvent.AUTH_USER, smtpInfos));
			
			// 334 + first three chars of 'UGF' which is part of the word 'password' base64 encoded
			else if (smtpReturn == SMTPMailer.AUTH_CHALLENGE && (response.toLocaleLowerCase().indexOf("ugf") != -1)) dispatchEvent(new SMTPEvent(SMTPEvent.AUTH_PASS, smtpInfos));
			
			else if (smtpReturn == SMTPMailer.AUTHENTICATED) dispatchEvent(new SMTPEvent(SMTPEvent.AUTHENTICATED, smtpInfos));
			
			else if (smtpReturn == SMTPMailer.DISCONNECTED) dispatchEvent(new SMTPEvent(SMTPEvent.DISCONNECTED, smtpInfos));
			
			else if (smtpReturn == SMTPMailer.BAD_SEQUENCE) dispatchEvent(new SMTPEvent(SMTPEvent.BAD_SEQUENCE, smtpInfos));
			
			else if (smtpReturn == SMTPMailer.DATA) dispatchEvent(new SMTPEvent(SMTPEvent.DATA, smtpInfos));
			
			else if (smtpReturn != SMTPMailer.DATA) dispatchEvent(new SMTPEvent(SMTPEvent.MAIL_ERROR, smtpInfos));
		}
		
		private function ioErrorHandler(e:Event) : void
		{
			return;
		}
	}
}