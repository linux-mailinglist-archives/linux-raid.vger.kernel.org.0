Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C3E55B43C
	for <lists+linux-raid@lfdr.de>; Mon, 27 Jun 2022 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiFZV6b (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 26 Jun 2022 17:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiFZV6b (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 26 Jun 2022 17:58:31 -0400
Received: from mallaury.nerim.net (smtp-100-sunday.noc.nerim.net [178.132.17.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6BA52DC5
        for <linux-raid@vger.kernel.org>; Sun, 26 Jun 2022 14:58:30 -0700 (PDT)
Received: from [192.168.0.250] (plouf.fr.eu.org [213.41.155.166])
        by mallaury.nerim.net (Postfix) with ESMTP id F0F4DDB17C;
        Sun, 26 Jun 2022 23:58:29 +0200 (CEST)
Message-ID: <280fbcb3-46e6-8eda-1a75-06c788d0b9d5@plouf.fr.eu.org>
Date:   Sun, 26 Jun 2022 23:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: a new install - - - putting the system on raid
Content-Language: en-US
To:     Wols Lists <antlists@youngman.org.uk>,
        o1bigtenor <o1bigtenor@gmail.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <CAPpdf59G6UjOe-80oqgwPmMY14t0_E=D20cbUwDwtOT8=AFcLQ@mail.gmail.com>
 <81c50899-7edb-e629-3bbc-16cfa8f17e34@youngman.org.uk>
 <b777865e-b265-1e83-dae0-f89654e86332@plouf.fr.eu.org>
 <5cbd9dd1-73fc-ce11-4a9d-8752f7bea979@youngman.org.uk>
 <1de4bf1f-242b-7d02-23dc-a6d05893db81@plouf.fr.eu.org>
 <9ff8c1e7-7c29-6243-2749-c6e0a3e25640@youngman.org.uk>
 <350e9a93-7af1-d5e6-62d7-a427e3e78eee@plouf.fr.eu.org>
 <7d08fbbb-fefa-f57b-d12b-af0f16a3daba@youngman.org.uk>
From:   Pascal Hambourg <pascal@plouf.fr.eu.org>
Organization: Plouf !
In-Reply-To: <7d08fbbb-fefa-f57b-d12b-af0f16a3daba@youngman.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Le 25/06/2022 à 13:41, Wols Lists wrote :
> On 25/06/2022 09:27, Pascal Hambourg wrote:
>> Le 24/06/2022 à 01:44, Wol wrote :
>>>
>>> And? /tmp is *explicitly* not to be trusted in the event of problems. 
>>> If you lose a disk and it takes /tmp out, sorry.
>>
>> Source ?
> 
> Linux Filesystem Hierarchy Standard? The presence of ANY files in /tmp 
> is not to be trusted - even if you created it ten seconds ago ...

This is not the same as /tmp becoming unusable at all.

As I wrote (and you cut), open files are not deleted and can still be 
read and written to until they are closed. They are only unlinked from 
the directory tree. It is actually rather common to unlink temporary 
files just after opening them, so that they are deleted automatically 
when they are closed.
