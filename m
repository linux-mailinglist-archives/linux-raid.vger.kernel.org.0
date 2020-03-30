Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3609F197CDA
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgC3N1P (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 09:27:15 -0400
Received: from mail.thelounge.net ([91.118.73.15]:55865 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgC3N1P (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Mar 2020 09:27:15 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 48rYCj2VJKzXMK;
        Mon, 30 Mar 2020 15:27:13 +0200 (CEST)
Subject: Re: mdcheck: slow system issues
To:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-raid@vger.kernel.org
References: <2933dddc-8728-51ac-1c60-8a47874966e4@molgen.mpg.de>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <5693a405-2722-03e9-2f63-c5916022dc60@thelounge.net>
Date:   Mon, 30 Mar 2020 15:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2933dddc-8728-51ac-1c60-8a47874966e4@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 30.03.20 um 14:18 schrieb Paul Menzel:
> How do you run `mdcheck` in production without noticeably affecting the
> system?

you can' for years

either lower "dev.raid.speed_limit_max" and wait ages for the raid check
or cripple system performance

i remember "dev.raid.speed_limit_max" did 10 years ago what it is
supposed to do: use that when the system is idle but slow down the
raid-check in case of heavy user-io

but the current drama exists for many years
