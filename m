Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB015E232E
	for <lists+linux-raid@lfdr.de>; Wed, 23 Oct 2019 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbfJWTL6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 23 Oct 2019 15:11:58 -0400
Received: from secmail.pro ([146.185.132.44]:33826 "EHLO secmail.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731793AbfJWTL6 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 23 Oct 2019 15:11:58 -0400
Received: by secmail.pro (Postfix, from userid 33)
        id ED6CEDF9CF; Wed, 23 Oct 2019 19:09:54 +0000 (UTC)
Received: from secmailw453j7piv.onion (localhost [IPv6:::1])
        by secmail.pro (Postfix) with ESMTP id 6F3571F3578;
        Wed, 23 Oct 2019 12:11:55 -0700 (PDT)
Received: from 127.0.0.1
        (SquirrelMail authenticated user hhardly@secmail.pro)
        by giyzk7o6dcunb2ry.onion with HTTP;
        Wed, 23 Oct 2019 12:11:55 -0700
Message-ID: <175412254efcb31804048e54fe9915b8.squirrel@giyzk7o6dcunb2ry.onion>
In-Reply-To: <3046fd1c514436358817c807cd9dfd52.squirrel@giyzk7o6dcunb2ry.onion>
References: <0a32d9235127ec7760334c3308ee6384.squirrel@giyzk7o6dcunb2ry.onion>
    <aff61b6a-15e1-555a-e507-f8dcfcfd3135@intel.com>
    <436ad5949675c156e4062fb23e27c482.squirrel@giyzk7o6dcunb2ry.onion>
    <5fdd5c39-5018-aff6-e0f8-7c2eb5f08c2d@intel.com>
    <3046fd1c514436358817c807cd9dfd52.squirrel@giyzk7o6dcunb2ry.onion>
Date:   Wed, 23 Oct 2019 12:11:55 -0700
Subject: Re: How to assemble Intel RST Matrix volumes?
From:   hhardly@secmail.pro
To:     "Artur Paszkiewicz" <artur.paszkiewicz@intel.com>
Cc:     linux-raid@vger.kernel.org
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>> Can you use the original disk to assemble the array and keep the copy as
>> backup? Then you can rebuild the array and later replace this disk with
>> another
>> one if you want.
>
> That makes sense. However, using the original physical drive, I get the
> same result.

This is caused by attaching devices over usb.  Although the correct serial
can be seen with smartctl, the device also seems to have another serial
number applied to it used by other tools including mdadm.  I fixed this by
attaching directly to internal SATA -- mdadm sees the right serial and
assembled everything correctly and I am in the process of retrieving the
needed data.

Thank you for your help. The world is a better place for people like you
who take time to help others.

