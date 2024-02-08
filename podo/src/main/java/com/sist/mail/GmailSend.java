package com.sist.mail;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class GmailSend {
	private static class SMTPAuthenticator extends Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			//발송할 이메일과 발급받은 앱키
			return new PasswordAuthentication("kei01118@gmail.com", "dgtbpmdilfspwqts");
		}
	}
	
	public static int send(String title, String content, String toEmail) {
		//Properties p = new Properties();
		Properties p = System.getProperties();
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.host", "smtp.gmail.com");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.port", "587");
		p.put("mail.smtp.user", "kei01118@gmail.com");
		p.put("mail.smtp.debug", "true");
		
		//SSL 오류로 인한 프로퍼티 추가 
		p.put("mail.transport.protocol", "smtps");
		p.put("mail.smtp.ssl.trust","smtp.gmail.com");
		p.put("mail.smtp.ssl.protocols","TLSv1.2");
		
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(p, auth);
			session.setDebug(true); 
			MimeMessage msg = new MimeMessage(session);
			String message = content;
			msg.setSubject(title);
			Address fromAddr = new InternetAddress("kei01118@gmail.com"); 
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(toEmail); 
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(message, "text/html;charset=UTF-8");
			Transport.send(msg);
			return 250;
		} catch (Exception e) { 
			e.printStackTrace();
			return 0;
		}
	}
}
