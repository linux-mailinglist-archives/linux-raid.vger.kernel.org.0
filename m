Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB1F09BE
	for <lists+linux-raid@lfdr.de>; Tue,  5 Nov 2019 23:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfKEWqM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Nov 2019 17:46:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29916 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728515AbfKEWqM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Nov 2019 17:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572993971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=So8Cf3GelXsUjBgLfzLC23CHNsQSgKI9J7EOShl7N1Y=;
        b=MCNuNalm2Dv4ntEPMr1dT117QlZgvv3P5HuBDtdMzewjdWqKaPTf112P8QAqRJKxyrhyyX
        mu3TOO+uARfcipr2X0HdRTPqi6aCrDL7fAXLmwIsxplqeG4bdIT9tHQV74SPLWZ7KIn+0u
        1qmECgB1zEw6p10RN7JXgk3oVLW84MQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-EMRnalkwNG-t0gOqJPCRpw-1; Tue, 05 Nov 2019 17:46:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 248021005500;
        Tue,  5 Nov 2019 22:46:06 +0000 (UTC)
Received: from [10.10.123.46] (ovpn-123-46.rdu2.redhat.com [10.10.123.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8685019C4F;
        Tue,  5 Nov 2019 22:46:05 +0000 (UTC)
From:   Nigel Croxon <ncroxon@redhat.com>
Subject: Re: [PATCH] raid456: avoid second retry of read-error
To:     Wols Lists <antlists@youngman.org.uk>, linux-raid@vger.kernel.org,
        liu.song.a23@gmail.com
References: <20191104200157.31656-1-ncroxon@redhat.com>
 <5DC0C34B.1040102@youngman.org.uk>
Message-ID: <dc736544-465e-f4eb-ca6d-e7b135074839@redhat.com>
Date:   Tue, 5 Nov 2019 17:46:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5DC0C34B.1040102@youngman.org.uk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: EMRnalkwNG-t0gOqJPCRpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


On 11/4/19 7:33 PM, Wols Lists wrote:
> On 04/11/19 20:01, Nigel Croxon wrote:
>> The MD driver for level-456 should prevent re-reading read errors.
>>
>> For redundant raid it makes no sense to retry the operation:
>> When one of the disks in the array hits a read error, that will
>> cause a stall for the reading process:
>> - either the read succeeds (e.g. after 4 seconds the HDD error
>> strategy could read the sector)
>> - or it fails after HDD imposed timeout (w/TLER, e.g. after 7
>> seconds (might be even longer)
> Okay, I'm being completely naive here, but what is going on? Are you
> saying that if we hit a read error, we just carry on, ignore it, and
> calculate the missing block from parity?
>
> If so, what happens if we hit two errors on a raid-5, or 3 on a raid-6,
> or whatever ... :-)
>
> Cheers,
> Wol

This allows the device (disk) to fail faster.=A0 All logic is the same.

If there is a read error, it does not retry that read, it calculates

the data from the other disks.=A0 This patch removes the retry.

-Nigel

