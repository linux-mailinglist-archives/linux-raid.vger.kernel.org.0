Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94862155B2E
	for <lists+linux-raid@lfdr.de>; Fri,  7 Feb 2020 16:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgBGPxr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 10:53:47 -0500
Received: from mail.thelounge.net ([91.118.73.15]:56333 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgBGPxr (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 10:53:47 -0500
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 48Dfwn1y9MzXQQ;
        Fri,  7 Feb 2020 16:53:45 +0100 (CET)
Subject: Re: Question
To:     o1bigtenor <o1bigtenor@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <b75c2dc2-d14e-39dc-0c06-7bab53fa7cb8@thelounge.net>
Date:   Fri, 7 Feb 2020 16:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Am 07.02.20 um 16:49 schrieb o1bigtenor:
> Running a Raid-10 array made up of 4 - 1 TB drives on a debian testing
> (11) system.
> mdadm - v4.1 - 2018-10-01 is the version being used.
> 
> Some weirdness is happening - - - vis a vis - - - I have one directory
> (not small) that has disappeared. I last accessed said directory
> (still have the pdf open which is how I could get this information)
> 'Last accessed 2020-01-19 6:32 A.M.'  as indicated in the 'Properties'
> section of the file in question.
> 
> Has been suggested to me that I make the array read only until this is resolved.
> I have space on the the array on a different system to recover this array.
> Suggestions on how to do both of the above would be aprreciated

directories on a filesystem on top of a RAID don't disappear silently -
my bet is a simple drag&drop move or deletion aka PEBCAK
