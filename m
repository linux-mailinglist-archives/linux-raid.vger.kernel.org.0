Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2581613867B
	for <lists+linux-raid@lfdr.de>; Sun, 12 Jan 2020 13:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbgALMry (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Jan 2020 07:47:54 -0500
Received: from li1843-175.members.linode.com ([172.104.24.175]:48810 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732823AbgALMry (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 12 Jan 2020 07:47:54 -0500
Received: from quad.stoffel.org (66-189-75-104.dhcp.oxfr.ma.charter.com [66.189.75.104])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id B9822225DC;
        Sun, 12 Jan 2020 07:47:53 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 532D1A5EE9; Sun, 12 Jan 2020 07:47:53 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24091.5497.253499.381022@quad.stoffel.home>
Date:   Sun, 12 Jan 2020 07:47:53 -0500
From:   "John Stoffel" <john@stoffel.org>
To:     Leslie Rhorer <lesrhorer@att.net>
Cc:     linux-raid@vger.kernel.org
Subject: Re: mdadm not sending email
In-Reply-To: <6c7766cb-8698-e44e-e767-000d5dea5833@att.net>
References: <87skiztloo.fsf@hades.wkstn.nix>
        <6c7766cb-8698-e44e-e767-000d5dea5833@att.net>
X-Mailer: VM 8.2.0b under 25.1.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Leslie>  ??? I recently upgraded one of my servers to Debian Buster.?
Leslie> I have been using sSMTP as my MTA, but unfortunately it is no
Leslie> longer maintained.? I installed msmtp, instead, but now my
Leslie> mesages are no longer going out from mdadm.? I can run the
Leslie> command:

This is a problem with your mail setup, not with mdadm.  I suspect you
need to configure msmtp to use TLS and/or to submit the email to port
587 on att.net, where you do a full authenticated login.

Look at the examples here:

https://wiki.alpinelinux.org/wiki/Relay_email_to_gmail_(msmtp,_mailx,_sendmail
https://wiki.debian.org/msmtp

And follow the debuging info these guides give.  Once you get email
working properly, mdadm will send emails.  


Leslie> echo "Subject: Test: | sendmail lesrhorer@att.net

Leslie> and it works.? If I try:

Leslie> mdadm --monitor --scan --test -1

Leslie> I get:

Leslie> sendmail: the server did not accept the mail
Leslie> sendmail: server message: 550 Request failed; Mailbox unavailable
Leslie> sendmail: could not send mail (account default from /etc/msmtprc)

Leslie> and from /var/log/mail.err:

Leslie> Jan 12 03:43:40 RAID-Server msmtp: host=outbound.att.net tls=on auth=on 
Leslie> user=lesrhorer@att.net from=lesrhorer@att.net 
Leslie> recipients=lesrhorer@att.net smtpstatus=550 smtpmsg='550 Request failed; 
Leslie> Mailbox unavailable' errormsg='the server did not accept the mail' 
Leslie> exitcode=EX_UNAVAILABLE

