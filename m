Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDE160B7D
	for <lists+linux-raid@lfdr.de>; Mon, 17 Feb 2020 08:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgBQHUO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 17 Feb 2020 02:20:14 -0500
Received: from mail-40132.protonmail.ch ([185.70.40.132]:17161 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgBQHUN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 17 Feb 2020 02:20:13 -0500
Date:   Mon, 17 Feb 2020 07:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1581924011;
        bh=Umclqrr3M9xAOBnxx2lploaTb7BvSybm44MPoM8O9hs=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=d2fpW3870P3cZEQG+afbxz6c4Ts8SQHOtLYo/WkvmX/DGgwzBKuYHbkuWV8DUVsak
         6G7Ngsv3aWmFKj+yFohKn86bZWXFoeiq8xTYDxRw2t2Aup/9K3NOHKF93n4yjW4YZR
         t1epgmqg1n561RznsNIEsI0lpro6S4jzlwemMVMo=
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
From:   Fisher <fisherthepooh@protonmail.com>
Reply-To: Fisher <fisherthepooh@protonmail.com>
Subject: mdadm: not zeroing non-valid bad block log content in newly added disk
Message-ID: <ZCC5pso8ZQLBtsLjK-LJY3XYVwZVB69vRPXXqmhgUeOBf9wpb5h2pjqpvvS2O9n5ztEtGmG3izyYpjZmrS1wIRSwO2vPXPzVOSBgvpvzhVM=@protonmail.com>
Feedback-ID: 9Qu1KKHEcnQ-bKszPau2cdh2be1P4X3006lMkI1eP2SK_OSh15c0De44Tu-Egx84xTck3dONeTWRCjCwoqkXdw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I got a 2-disk raid1 and I was trying to add a new disk to this array,

right after it was added in, before any IOs came in

I found there're bad blocks present from mdadm --examine

and the bad block log content was like

    8664206884405890 for 512 sectors
    8664206884406402 for 125 sectors
    8798941702130700 for 49 sectors
   18014398509481983 for 512 sectors

those offset and size weren't even valid

if I first zeroing the whole disk I would get

         0 for 0 sectors
         0 for 0 sectors
         0 for 0 sectors
         0 for 0 sectors

mdadm copied the superblock from one of the component disk to

the new disk before adding it to array, and that disk happened to

have bad blocks, so the new disk would have bad block flag set

but with a bunch of non-valid content in the log, there're chances

that this disk might be rejected by kernel while loading bad block list.

Looks like it was a false alarm, I was wondering is there any

reason not to clean bad block log before new disk adding in?

Thanks,
