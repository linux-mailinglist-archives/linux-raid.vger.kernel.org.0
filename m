Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7941A5D32
	for <lists+linux-raid@lfdr.de>; Sun, 12 Apr 2020 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDLHl0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Apr 2020 03:41:26 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:34604 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLHl0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 12 Apr 2020 03:41:26 -0400
Date:   Sun, 12 Apr 2020 07:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1586677284;
        bh=RCIZz/EbokNagC01U9THUUYH73dlDWPooeeW4hZgJi0=;
        h=Date:To:From:Reply-To:Subject:From;
        b=C/yTdZ18V+QN6J8tvtjX/8T7O0QJ+wkjftiVdHpWwk+7vzymad/X6mGTJTG5/H2On
         PKlhAigYyrACeKM298tMaPx1ikq3RKV2gyWFsokPeU+q2Sre8CLk11VAW6E4fCalpe
         /zbliTrkvDU3hN4kLYMT7+oxdd/i4qGDYcLcKGes=
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
From:   Jonas Fisher <fisherthepooh@protonmail.com>
Reply-To: Jonas Fisher <fisherthepooh@protonmail.com>
Subject: RAID0 with only one zone
Message-ID: <U_VZCfOb6kXQkP0UHckeJnw9xb4SWfhBpSIccNq-gB0B1EugPbxRIKu2eFjpOucWClEneY__W8pBJHBdkfAK5KuNC3mHiN19knwIDOOQZdU=@protonmail.com>
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

Hi all,

I got four disks with different size, and I want to create a raid0,
I think I would expand it in the future, but the only way to expand
a raid0 is to convert it to raid4 and convert it back to raid0.
But there's a limitation that there should be only one zone in
this raid0, I tried to specify --size on creation to limit
the disk size to the smallest one, but I found it not working,
I still got more than one zone.

It seems weird that multi-zones are created even though I've
specified the device size... Or, is there any way I can create
a raid0 with only 1 zone if I use the disks with different size?

Any enlightenment is appreciated. Thanks.
