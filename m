Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A96174FC1
	for <lists+linux-raid@lfdr.de>; Sun,  1 Mar 2020 22:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgCAVDm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 1 Mar 2020 16:03:42 -0500
Received: from sonic311-19.consmr.mail.bf2.yahoo.com ([74.6.131.193]:39017
        "EHLO sonic311-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbgCAVDm (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 1 Mar 2020 16:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1583096621; bh=qYUkJCSjG460bwC/AxFvDYhmd6cN2uwBQA1Jfh4f6HE=; h=To:From:Subject:Date:References:From:Subject; b=lkOGnEvbEHD4MhCWFEoypVHdPWTTb3u4FfaQ/Wc4whbN/jLrOvj1ugw8PRMzosr77/foClLaEvr4XZCEXTNoeD5jlZkNEsq2I01YK6NUlMcueN9hpk5RF+fte9/pyx5HiI9Pc86ic02bozLJcixMbCmJ9QCXAZDUkgdrZC0XzpM=
X-YMail-OSG: 438HY4sVM1mt.owKW2.EwE_JLxAu6qly_UNo8acMmwUBPeCa_ZT5ivic2GKvXgW
 0eGmRepOFYCUKtMD2U2qzBffXOSecTV2qTztakXmpfGDR1Uq91wc.KiOh60sIREhqSfyvuVHqL2J
 fJt1y7kf0DOveJ.0CowwLuJNtCJcuLQ13KjxbG1BfsbfyCC9.E_ItpojaLhw7kwjfN4_g73rCGvk
 4oplFBa7BtL4KED77An7DS6qf.1FeikvI3rcY_9YpDQs0YITQwjLlFJDUmuwqKuTEBwQfJQTAURn
 OkW_BySBMN1CO_LY9s2Yqr2czWTruwRbbeY2YK.4dfmHjErPORqhsI2ureu0mgXuDm4nWtySQCx3
 _Fmx6ZryMslaDyg3mpsU7LYU1hMJ1iZ0jZexbkhrCc5YIBGc5Yszdd0CBkrpNzhOLYd9NH.7bslW
 gXyQOPkmnlPruJrN0zkBlhvwJfAkKIZwxe8AH1YxET0iSaq_4c3ep3L2l3AdFySrMxDLKdreNK8i
 HVgFuOstbTGyTjSWKf7rnwdaLMjceoX_qzmx_wxXx5y8K07qUvlXiHzbj_xkDJz8m_A0BHaj3axe
 SPSqxEK4tULtHpSVF9uKWkFGXcZdylqE8KG.XWfAhsMS5cefS2EkGhJtK4.c.7tP8NLAnZFAqIz3
 UmAZRt3K0TckZ7I953q00My3x7aHnba.smGUgr3hhV6_.C1gtvEjkJvvCE4oHBMGAvuxG5dHoCkA
 AesKdXuj8BQ9qaNxgzTI2p3QNzmdhHhLusfkaPX1qHTYLi.kYo5F5zQcIaiu6KvLy8BIPNg4FGsL
 kfFfDb1UaSp1P7j4biM.EemA6SJBmeYaErZ1Vkt6o32oxMwIPywGeyk_xfcGXqqiCUGQvl3CuOrD
 xMYrUPLtQvvc4qGdBLBY3UTjDDA4WpqY54dM_kJfIw4L8X3b8SSZSkjR2ZfGwWkT1AtzAAgPhf0g
 uK5eV8NcTcyt05OrJjZE_2EefjJ_kY.2PsB4WuqZ3px4aKuo5_ssXWG4y9_pF.u0lhxLJMabonkl
 4t9OrY2gL3dTVDS3z_POPwL7DKl_9b0A4RYQNDCxvHYQQnIdNFwddbNW_QlUac.Qn0m.R1zOiiyv
 CmM_y81W4Da8gIn8ZCoeDnMb6Y5kJ2LCAlpFO9ukdV38uvaSTrZ6yxQmfZSGt.J_2KIS9BaY9TzP
 hFdSDCjTl6DKuFNAN1uLBShtAP209zln0_YMFTQb6E0Oa6SKIhioVb4vLffL8afXIH5BmLr8FI4l
 a0NvDmLvdErTt2HBFaHZ0ghmXEecqB1CCv8dK1lDAiAt4vFjqXhEOKJlPEk9fxswPrc9nGk5y.1D
 EhRW4zcoGz_oW9jLei8Q.V9gvlqW_geYhZNhoh.gYVtskwZ.5ongQhRZYgyw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Sun, 1 Mar 2020 21:03:41 +0000
Received: by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4927bdcbd92c07e551081787a97fa5b1;
          Sun, 01 Mar 2020 21:03:39 +0000 (UTC)
To:     linux-raid@vger.kernel.org
From:   Leslie Rhorer <lesrhorer@att.net>
Subject: checkarray not running or emailing
Message-ID: <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
Date:   Sun, 1 Mar 2020 15:03:37 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
X-Mailer: WebService/1.1.15302 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

     I have upgraded 2 of my servers to Debian Buster, and now neither 
one seems to be running checkarray automatically.  In addition, when I 
run checkarray manually, it isn't sending update emails on the status of 
the job.  Actually, I have never been able to figure out how checkarray 
runs.  One my older servers, there doesn't seem to be anything in 
/etc/crontab, /etc/cron.monthly, /etc/init.d/, /etc/mdadm/mdadm.conf, or 
/lib/systemd/system/ that would run checkarray.

