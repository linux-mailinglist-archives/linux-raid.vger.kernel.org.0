Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612DE2CF9EF
	for <lists+linux-raid@lfdr.de>; Sat,  5 Dec 2020 07:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgLEGHb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Sat, 5 Dec 2020 01:07:31 -0500
Received: from mout.perfora.net ([74.208.4.194]:45157 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgLEGHb (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 5 Dec 2020 01:07:31 -0500
Received: from android-de2ab3c23f073453.home ([72.94.51.172]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MhBR9-1kY2SK3ru5-00MND5 for <linux-raid@vger.kernel.org>; Sat, 05 Dec 2020
 06:59:34 +0100
Date:   Sat, 05 Dec 2020 00:59:30 -0500
User-Agent: K-9 Mail for Android
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Disk identifiers
To:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
From:   H <agents@meddatainc.com>
Message-ID: <5B155FE8-2761-47FF-BDBA-F5AE3A9BC396@meddatainc.com>
X-Provags-ID: V03:K1:mbKm3qj1NmPsMIvcPuMnS9gSEvf1vXPe0fVdg+3jmdGETc0eqrE
 vPcbLvlsUY3iJ39+Y0Ckv54r9WPR4WX/56j3sDoxPYwlUn5CYfh1oYFb7yQurM9ajPwWxQ1
 p4HLUfSn0luUoGZDeiC0So4dl3/5uqd+4o4BL64iVbROZqGP+RVDPAjYQoUSs6cFjny57Mx
 fEojn16SoF6rSgfuPNWKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmFCPGCkmrU=:J4RznsPwcksZS3LSTYCBpX
 5BkRkQdWqsMo1lt8dtcWiCWp5hvKh3lyUOPCK6ba2RaxruEX+vkr0UZL27ZgHQoxw8iIZy7JR
 9wWy7IlXxbdpo3NfsQXqwyc8ZX6CVP9tGXY08uECyCN00kdfNVxkGhEC8ObNATXgIIcS/3+Uc
 NwIHPxx7PdHmUYZYxHNHt48foj+SuXmT59QKvI/7DTK7svasXj2H+Ky2GLXHtRRDhZzup9WkI
 OMrjSRjYLG8AXZcC7B7VWa00gKvqK54CeYs7ML2mVOkEiZCABP6bKzzkSXY/DYxjwC0+jsVk0
 T9flUksrJEzPA36Kd8+lDSEj7N0S1E+comcCA+UUM6xwmb+oAQe7YHU6e5JuMLZltTpcro8yv
 etcCfUsI2WST8qF3DNXYJbeGjGb1UNhvD+K6fTqLtIAzkI3R0npOcPOPiFBbrYBS0mAJBKNsu
 FDRcWmhTjA==
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Are disk identifiers important in Linux (CentOS)? I have two disks that used to be in a Intel fake RAID1 configuration and I now see have identical disk identifiers of 00000000-0000-0000-0000000000. I now want to use only one of them and later use mdraid for a software RAID1 configuration.

Googling suggests that: (1) disk identifiers are /not/ important and (2) they are using the format 0x12345678. However fdisk -l displays the disk identifiers of my disks in the long UUID format. Further, another disk in the system does use a long UUID.

Last, googling suggests there is confusion between disk identifiers and partition UUIDs. I am specifically asking about the former.
