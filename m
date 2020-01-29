Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D514D20E
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jan 2020 21:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgA2Uqh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 Jan 2020 15:46:37 -0500
Received: from sonic316-15.consmr.mail.bf2.yahoo.com ([74.6.130.125]:44790
        "EHLO sonic316-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbgA2Uqg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Wed, 29 Jan 2020 15:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1580330794; bh=wWukAFHhdCVvEz1JKQwz3duu5CzT/T/j2PI2RfpUTLk=; h=Subject:From:To:References:Date:In-Reply-To:From:Subject; b=AgKYjRZPB+edPBnbYvjEldRhiwVWZ3AKYXPvFTLQzxvZTN4yvNDt+DT+WQN4jyWDFeshPgoZq+KesTryZ+sc2jFVAJ+OrHi4HrDkf1GRpeLMDgviHhg4i8Dnu3wgr6YeEZl6oA/Ngx0SfOr9YsM4CvSZUMyMYPd4YOs0Za426DU=
X-YMail-OSG: 9Bb28YQVM1mV0gQPGeKulZOlHTfl2eaJAsoqeNOUX.qMlKS23pUN_L.anLGcmV_
 43rsYScEh0oHem3kyGA6ZQWyZrjpM4rUVT7q2.Vzn1wUrPEEr62JvljMZQQeTL8WpPAS4FZgHBdB
 1qvJLQxMLoPOwXVNbtj0GM7Plcm7NUqcyJHdzmVSvC_xNWYbC6ywfb7.RZyZoIEW5e5Cfk9LvQod
 n4JCGyypQz5FNusuITa910SrBgzFjkHhnRAnQvFqvKvm4z_uRsWFiTVWxXAuWiv6EDiPQHHHSaQ6
 QGGDsmi19vJhm_wH8XIB7Zwm46obO8RIZOp6V5YChdXM7.S0aBvjc_MUdIrSzyXt5b0buXtTf7jh
 1I39fkSYduAHgmOBngGgfqf9HQCK2NFGT6T50pxbGYQ8V0SKUNdD49oWzhgfJ1JLMlEpjHpH9TqG
 4ocbBeWCCPp2nQkYz39elGOVRxmoolsDMbPcmITFVcJaqVXCPhPJpboPYKiX9QfexhCrZ1Zi6DpZ
 oWUmwDbPWdYteunk.gTBL6lF.qA_GO2233SMPczZlPaziWgSjpWmo2787Z8oZ6aBvEsPb_.Zauks
 Upji8eQ3xgXSsHg5JURrE8VmxXKd8xyA5A8F6C90Pf1fe87nNansyN2apsp7PJWplhuYgd40vUKm
 6cpZ7vUadjANrv7RYS_UubHqJD8ovEp68XSInksy6xcJ1EPkFDEA6WsfYdhmyeiW5bu2aKksoCv5
 H6ezZNztE7VPSvxYTUcEhSbiL.6y4OVGa8REAEtxNrjxpOLqj_r7oKSaUWxQMYcK7ryd2ByRWvx0
 zqvXJuEer.qgEw..aXx43YPTt_2Te2pykfmQRLK6mW7ZwjhHV.9ol_Xtuo9RfJ8i8D4l6FD_N7uP
 N5M7R5rRiHauPEe4_Edppx2bOZhHZC9L7U2IZd1yEFgUnpF98.KZUq2Lce5VVx.GNeE6myf4xgay
 UkUl8dYQYJJ2_.osNy6fg.hX05rMdokFQPSZs.rRrZNW1Lwx0M0M9.hQmdaH6yLR2a8.Bg7W7cWA
 SMKaDYocwSwDuzbHGrMVQHLM.zPbYnK1ocf15eCodUNgwoeFKnqSXEimouG3y3mRfuD.aXPojAS6
 OZD7QmovX4UaeQppYrD34aeuq89fliQGP3W6I1Hs4t..aGWCzxEwjBcII5L1rgUJyITlwyGNHN41
 pcH.SjF5k_L0pJer_.NAvjaailYzspFu8NB87DWch0PjomQ7wYlHEEAMjiUEdymGa3WcCfi_Zp30
 W.e4lpIluRniTbiXSOXXtN7yoiUr6oEGMw8CwcjfinTYT1qLtE4YHEwx.cd9ZJxlzuyX2GalBEtQ
 5niEDqmD2hueZ_IiLzJoBwe4Zn0aIfELCKAtWzXc1wxMNhRTuCESi3Vaa3vcQPK5VR8BX6wFZ0vb
 Q
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 Jan 2020 20:46:34 +0000
Received: by smtp410.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 28762883979056a8aa02586d683df141;
          Wed, 29 Jan 2020 20:46:34 +0000 (UTC)
Subject: Re: mdadm not sending email
From:   Leslie Rhorer <lesrhorer@att.net>
To:     linux-raid@vger.kernel.org
References: <87skiztloo.fsf@hades.wkstn.nix>
 <6c7766cb-8698-e44e-e767-000d5dea5833@att.net>
 <24091.5497.253499.381022@quad.stoffel.home>
 <381d32b6-eee7-63c6-7cb4-64a58a0f6796@att.net>
Message-ID: <4da133ff-f17f-cb49-20e0-7953808e54ec@att.net>
Date:   Wed, 29 Jan 2020 14:46:29 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <381d32b6-eee7-63c6-7cb4-64a58a0f6796@att.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15116 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

     I believe I have fixed the problem.  For anyone else who runs 
across this:

1. Add both the following ines into /etc/mdadm/mdadm.conf

MAILADDR <recipient>

MAILFROM <sender>

2. Create a symlink in /usr/sbin

cd /usr/sbin

ln -s ../bin/msmtp sendmail

On 1/13/2020 8:00 AM, Leslie Rhorer wrote:
>     I forgot to send this out to the list.  I apologize for any 
> duplicates.
>
> On 1/12/2020 6:47 AM, John Stoffel wrote:
>> Leslie>  ??? I recently upgraded one of my servers to Debian Buster.?
>> Leslie> I have been using sSMTP as my MTA, but unfortunately it is no
>> Leslie> longer maintained.? I installed msmtp, instead, but now my
>> Leslie> mesages are no longer going out from mdadm.? I can run the
>> Leslie> command:
>>
>> This is a problem with your mail setup, not with mdadm.  I suspect you
>> need to configure msmtp to use TLS and/or to submit the email to port
>     It is using TLS.
>> 587 on att.net, where you do a full authenticated login.
>
>     Nope, 465, which by the way is the default for SSL/TLS, and I am 
> doing a full authenticated login.  Now, it is certainly arguable, 
> perhaps even likely, my mail setup has a problem, but without knowing 
> specifically what mdadm is sending out, I am going to be hard pressed 
> to know what I need to modify in my mail setup.
>
>     In the earlier version of mdadm, the mail utility (specified in 
> /etc/mdadm/mdadm.conf) was the script /usr/bin/mdadm_notify.  I have 
> no idea how or whatt he newer version f mdadm sends out.
>
>>
>> Look at the examples here:
>>
>> https://wiki.alpinelinux.org/wiki/Relay_email_to_gmail_(msmtp,_mailx,_sendmail 
>>
>> https://wiki.debian.org/msmtp
>
>
>     I had already looked at both of those, and although the 
> configuration for att.net is different than for gmail, nothing jumps 
> out at me.
>
>
> Here is my configuration for msmtp:
>
> # Example for a system wide configuration file
>
> # A system wide configuration file is optional.
> # If it exists, it usually defines a default account.
> # This allows msmtp to be used like /usr/sbin/sendmail.
> account default
>
> # The SMTP smarthost
> host outbound.att.net
>
> # Use TLS on port 465
> port 465
> tls on
> tls_starttls off
>
> # Construct envelope-from addresses of the form "user@oursite.example"
> #auto_from on
> #maildomain att.net
>
> from lesrhorer@att.net
> user lesrhorer@att.net
> auth on
> password XXXXXXXXXXX
>
> # Syslog logging with facility LOG_MAIL instead of the default LOG_USER
> syslog LOG_MAIL
>
> Mail is working on another server that still uses ssmtp.  Here is the 
> configuration:
>
> # Config file for sSMTP sendmail
> #
> # The person who gets all mail for userids < 1000
> # Make this empty to disable rewriting.
> root=lesrhorer
>
> # The place where the mail goes. The actual machine name is required no
> # MX records are consulted. Commonly mailhosts are named mail.domain.com
> mailhub=outbound.att.net
>
> # Where will the mail seem to come from?
> rewriteDomain=att.net
>
> # The full hostname
> hostname=localhost
>
> # Are users allowed to set their own From: address?
> # YES - Allow the user to specify their own From: address
> # NO - Use the system generated From: address
> FromLineOverride=YES
>
> AuthUser=lesrhorer@att.net
> AuthPass=XXXXXXXXXXXXX
> UseTLS=YES
>
>>
>> And follow the debuging info these guides give.  Once you get email
>
>     I don't see any debugging recommendations in either document.
>
>
>     One interesting thing: When I run the monitor / test command on 
> the older system, sendmail complains about the mailbox being 
> unavailable, but it still sends out the email.
